module Inquisition
  module Brakeman
    class Runner < ::Inquisition::Runner
      def call
        puts 'Inquisition::Brakeman::Runner'
      end
    end
  end
end
