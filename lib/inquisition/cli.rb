module Inquisition
  class CLI < Thor
    desc 'install', I18n.t('messages.creates_config_files')
    def build(*_args)
      Builder.call
    end

    desc 'setup', I18n.t('messages.setups_all_conf_linters')
    def setup(*_args)
      Configure.call
    end

    desc 'analyze', I18n.t('messages.run_all_linters')
    class_option 'format', aliases: '-f', type: :string, enum: Outputer::OUTPUTERS_FORMAT.keys, default: 'html'
    def analyze(*_args)
      Core::AuditorsData.instance.add_data(Runner.new.call)
      Outputer.call(options)
    end
  end
end
