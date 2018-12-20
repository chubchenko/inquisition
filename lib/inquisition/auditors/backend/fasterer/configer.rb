module Inquisition
  module Auditors
    module Backend
      module Fasterer
        class Configer < Inquisition::Core::Configer
          class << self
            def config_name
              '.fasterer.yml'
            end

            def linter_name
              'Fasterer'
            end
          end
        end
      end
    end
  end
end
