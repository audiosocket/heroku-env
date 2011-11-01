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
      if app && pattern?
        prefix, suffix = pattern.split "%s"

        unless app.start_with?(prefix) or app.end_with?(suffix)
          app = pattern.sub "%s", app
        end
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
  alias_method :extract_app_without_env, :extract_app

  def extract_app
    options[:app]     = Heroku.env.munge options[:app] || Heroku.env.default
    options[:confirm] = Heroku.env.munge options[:confirm]

    warn "Running on #{options[:app]}."
    extract_app_without_env
  end
end
