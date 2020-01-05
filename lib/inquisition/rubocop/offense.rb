module Inquisition
  module Rubocop
    class Offense < ::RuboCop::Cop::Team
      def offenses(processed_source)
        autocorrect_cops, other_cops = cops.partition(&:autocorrect?)
        investigate(autocorrect_cops, processed_source).offenses + investigate(other_cops, processed_source).offenses
      end
    end
  end
end
