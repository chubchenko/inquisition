module Inquisition
  module Auditors
    module Backend
      module RubyLint
        class Runner < Core::Runners::SingleRunner
          private

          def command
            'ruby-lint . -p json'
          end
        end
      end
    end
  end
end
