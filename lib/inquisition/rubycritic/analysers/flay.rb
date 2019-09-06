module Inquisition
  module Rubycritic
    module Analysers
      class Flay < ::RubyCritic::Analyser::FlaySmells
        def run
          @flay.hashes.each do |structural_hash, nodes|
            analyze_modules(structural_hash, nodes)
          end
        end
      end
    end
  end
end
