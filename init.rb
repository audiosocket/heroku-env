require "heroku/env" if File.file? ".heroku-env"

require "heroku/command/release"
