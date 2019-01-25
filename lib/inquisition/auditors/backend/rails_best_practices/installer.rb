module Inquisition
  module Auditors
    module Backend
      module RailsBestPractices
        class Installer < Auditors::Installer
          class << self
            private

            def configers
              [
                Core::Configers::CopyFileConfiger.new(file: 'rails_best_practices.yml')
              ]
            end
          end
        end
      end
    end
  end
end
