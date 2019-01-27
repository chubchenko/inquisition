module Inquisition
  module Auditors
    module Backend
      module LolDba
        class Runner < Auditors::Runner
          private

          def command
            'lol_dba db:find_indexes'
          end
        end
      end
    end
  end
end
