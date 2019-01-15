module Inquisition
  module Auditors
    module Backend
      module Fasterer
        class Installer < Auditors::Installer
          class << self
            private

            def configers
              # [
              #   Core::Configers::CopyFileConfiger.new(file: config_name),
              #   Core::Configers::UpdateFileConfiger.new(file: 'spec/spec_helper.rb', template_path: __dir__)
              # ]
            end

            def checkers
              [
                # Core::Checkers::ExistFileChecker.new(file: config_name),
                # Core::Checkers::GemChecker.new(name: gem_name),
                # Core::Checkers::RubyVersionChecker.new(from_version: '2.5.1'),
                Core::Checkers::AdditionalSoftwareChecker.new(command: 'npm -v')
              ]
            end

            def config_name
              '.fasterer.yml'
            end

            def linter_name
              'Fasterer'
            end

            def gem_name
              linter_name.downcase
            end
          end
        end
      end
    end
  end
end
