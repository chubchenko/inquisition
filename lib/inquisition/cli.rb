module Inquisition
  class Cli < Thor
    desc 'install', 'Creates configuration file'
    def build(*_args)
      Builder.call
    end

    desc 'setup', 'Setups all configs for linters'
    def setup(*_args)
      Configure.call
    end

    desc 'analyze', 'Running all linters'
    class_option 'format', aliases: '-f', type: :string, enum: Outputer::OUTPUTERS_FORMAT.keys, default: 'html'
    def analyze(*_args)
      Core::AuditorsData.instance.add_data(Runner.new.call)
      Outputer.call(options)
    end
  end
end
