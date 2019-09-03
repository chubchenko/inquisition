module Inquisition
  module Rubocop
    class Categorizer
      SPECIFIC_MATCH_TABLE = {
        'Bundler/DuplicatedGem' => :duplication,
        'Bundler/InsecureProtocolSource' => :security,
        'Metrics/LineLength' => :style,
        'Migrations/RemoveIndex' => :performance
      }.freeze

      COMMON_MATCH_TABLE = {
        'Security' => :security,
        'Metrics' => :complexity,
        'Performance' => :performance
      }.freeze

      def self.find_category(cop_name)
        return SPECIFIC_MATCH_TABLE[cop_name] if SPECIFIC_MATCH_TABLE.key?(cop_name)

        cop_module = cop_name.split('/')[0]
        return COMMON_MATCH_TABLE[cop_module] if COMMON_MATCH_TABLE.key?(cop_module)

        :style
      end
    end
  end
end
