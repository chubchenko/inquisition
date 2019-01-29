module Inquisition
  module Auditors
    module Backend
      module RubyLint
        class Runner < Auditors::Runner
          private

          def command
            'ruby-lint . -p json'
          end
        end
      end
    end
  end
end
