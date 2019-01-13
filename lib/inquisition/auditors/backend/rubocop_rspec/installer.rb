module Inquisition
  module Auditors
    module Backend
      module RubocopRspec
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
                Core::Configers::CopyFileConfiger.new(file: '.rubocop.yml')
              ]
            end
          end
        end
      end
    end
  end
end
