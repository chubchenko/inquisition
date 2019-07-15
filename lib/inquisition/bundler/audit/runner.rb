module Inquisition
  module Bundler
    module Audit
      class Runner < ::Inquisition::Runner
        def call
          puts 'Inquisition::Bundler::Audit::Runner'
        end
      end
    end
  end
end
