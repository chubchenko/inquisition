module Inquisition
  module Auditors
    module Backend
      module LolDba
        class Runner < Core::Runners::SingleRunner
          private

          def command
            'lol_dba db:find_indexes'
          end
        end
      end
    end
  end
end
