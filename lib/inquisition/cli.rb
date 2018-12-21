require 'thor'
require 'inquisition/authentication'

module Inquisition
  class CLI < Thor
    include Inquisition::Authentication

    desc 'install', 'Creates configuration file'
    def install(*_args)
      Inquisition::Installer.call
    end

    desc 'setup', 'Setups all configs for linters'
    def setup(*_args)
      authenticate_installer
      Inquisition::Configer.call
    end
  end
end
