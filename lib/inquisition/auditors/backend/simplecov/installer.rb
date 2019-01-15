module Inquisition
  module Auditors
    module Backend
      module Simplecov
        class Installer < Auditors::Installer
          class << self
            private

            def checkers
              [
                Core::Checkers::GemChecker.new(name: 'rspec-rails')
              ]
            end

            def configers
              [
                Core::Configers::UpdateFileConfiger.new(file: 'spec_helper.rb',
                                                        template_path: __dir__,
                                                        destination: 'spec')
              ]
            end
          end
        end
      end
    end
  end
end
