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
    class_option 'format', aliases: '-f', type: :string, enum: %w[html json], default: 'html'
    def analyze(*_args)
      formatters = Inquisition::Runner.new.call
      Inquisition::Outputer.call(options, formatters: formatters)
      # Core::Outputers::HtmlOutputer.new(formatters).call
    end
  end
end
