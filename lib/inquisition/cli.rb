module Inquisition
  class CLI < Thor
    desc 'install', I18n.t('messages.creates_config_files')
    def build(*_args)
      Inquisition::Builder.call
    end

    desc 'setup', I18n.t('messages.setups_all_conf_linters')
    def setup(*_args)
      Inquisition::Configure.call
    end

    desc 'analyze', I18n.t('messages.run_all_linters')
    def analyze(*_args)
      Inquisition::Runner.call
    end
  end
end
