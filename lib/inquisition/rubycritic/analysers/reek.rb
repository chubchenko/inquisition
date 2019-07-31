module Inquisition
  module Rubycritic
    module Analysers
      class Reek < ::RubyCritic::Analyser::ReekSmells
        def run
          @analysed_modules.each do |analysed_module|
            add_smells_to(analysed_module)
          end
        end
      end
    end
  end
end
