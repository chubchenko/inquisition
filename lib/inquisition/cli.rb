module Inquisition
  class CLI < Thor
    desc 'install', 'Creates configuration file'
    def install(*_args)
      Inquisition::Installer.call
    end

    desc 'setup', 'Setups all configs for linters'
    def setup(*_args)
      Inquisition::Configer.call
    end
  end
end
