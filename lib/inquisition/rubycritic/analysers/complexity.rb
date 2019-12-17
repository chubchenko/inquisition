module Inquisition
  module Rubycritic
    module Analysers
      class Complexity < ::RubyCritic::Analyser::Complexity
        def run
          @analysed_modules.each do |analysed_module|
            @flog.reset
            @flog.flog(analysed_module.path)
            analysed_module.complexity = @flog.total_score.round(2)
          end
        end
      end
    end
  end
end
