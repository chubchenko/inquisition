module Inquisition
  class CLI < Thor
    desc 'install', I18n.t('messages.creates_config_files')
    def install(*_args)
      Inquisition::Installer.call
    end

    desc 'setup', I18n.t('messages.setups_all_conf_linters')
    def setup(*_args)
      Inquisition::Configer.call
    end
  end
end
