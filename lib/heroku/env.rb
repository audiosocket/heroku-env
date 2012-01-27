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
      @config["default"]
    end

    def default?
      !!default
    end

    def munge app
      return app if app.nil? or not app.start_with? "@"

      if pattern?
        app = pattern.sub "%s", app[1..-1]
      end

      app
    end

    def pattern
      @config["pattern"]
    end

    def pattern?
      !!pattern
    end
  end
end

class Heroku::Command::Base
  alias_method :app_without_env, :app

  def app
    options[:app]     = Heroku.env.munge options[:app] || Heroku.env.default
    options[:confirm] = Heroku.env.munge options[:confirm]

    warn "Running on #{options[:app]}."
    app_without_env
  end
end
