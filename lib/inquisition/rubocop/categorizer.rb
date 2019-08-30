module Inquisition
  module Rubocop
    class Categorizer
      DETAILED_MATCH_TABLE = {
        'Bundler/DuplicatedGem' => :duplication,
        'Bundler/InsecureProtocolSource' => :security,
        'Metrics/LineLength' => :style,
        'Migrations/RemoveIndex' => :performance
      }.freeze

      MATCH_TABLE = {
        'Security' => :security,
        'Metrics' => :complexity,
        'Performance' => :performance
      }.freeze

      def self.find_category(cop_name)
        return DETAILED_MATCH_TABLE[cop_name] if DETAILED_MATCH_TABLE.key?(cop_name)
        return MATCH_TABLE[cop_name.split('/')[0]] if MATCH_TABLE.key?(cop_name.split('/')[0])

        :style
      end
    end
  end
end
