require "yaml"

module Heroku
  module Env
    @config = YAML.load File.read(".heroku-env")

    def self.[] key
      @config[key] || @config[key.intern]
    end

    def self.munge str
      if str && self[:pattern]
        prefix, suffix = pattern.split "%s"

        unless str.start_with?(prefix) or str.end_with?(suffix)
          str = pattern.sub "%s", str
        end
      end

      str
    end
  end
end

class Heroku::Command::Base
  alias_method :extract_app_without_env, :extract_app

  def extract_app
    options[:app]     = Heroku::Env.munge options[:app] || Heroku::Env[:default]
    options[:confirm] = Heroku::Env.munge options[:confirm]

    warn "Running on #{options[:app]}."
    extract_app_without_env
  end
end
