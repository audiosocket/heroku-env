class Heroku::Command::Base
  alias_method :extract_app_without_env, :extract_app

  def extract_app
    require "yaml"

    if File.file? ".heroku-env"
      env = YAML.load(File.read ".heroku-env")
      app = options[:app] || env["default"]

      if env && env["pattern"]
        prefix, suffix = env["pattern"].split "%s"

        if app && !app.start_with?(prefix) && !app.end_with?(suffix)
          app= env["pattern"].sub "%s", app
        end
      end

      warn "Running on #{app}."
      options[:app] = app
    end

    extract_app_without_env
  end
end
