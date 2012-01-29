require "yaml"

module Heroku
  def self.env
    @env ||= Env.new ".heroku-env"
  end

  class Env
    def initialize file
      @config = YAML.load File.read file
    end

    def default
      "@" + @config["default"] if @config["default"]
    end

    def munge app
      return app if app.nil? or not app.start_with? "@"
      pattern ? pattern.sub("%s", app[1..-1]) : app
    end

    def pattern
      @config["pattern"]
    end
  end
end

class Heroku::Command::Base
  alias_method :app_without_env, :app

  def app
    options[:app]     = Heroku.env.munge options[:app] || Heroku.env.default
    options[:confirm] = Heroku.env.munge options[:confirm]

    warn "App is #{options[:app]}." unless @already_said_which_app
    @already_said_which_app = true

    app_without_env
  end
end
