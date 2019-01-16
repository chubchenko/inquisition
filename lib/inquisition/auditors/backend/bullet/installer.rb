module Inquisition
  module Auditors
    module Backend
      module Bullet
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
                Core::Configers::UpdateFileConfiger.new(file: 'development.rb',
                                                        destination: 'config/environments',
                                                        template_path: __dir__)
              ]
            end
          end
        end
      end
    end
  end
end
