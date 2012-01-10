require "heroku/command/base"

class Heroku::Command::Release < Heroku::Command::Base

  # release
  #
  # release HEAD to app

  def index
    exec "git", "push", "-f", "git@heroku.com:#{app}.git", "HEAD:master"
  end
end
