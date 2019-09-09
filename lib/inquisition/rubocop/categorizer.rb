module Inquisition
  module Rubocop
    class Categorizer
      SPECIFIC_MATCH_TABLE = {
        'Bundler/DuplicatedGem' => Category::DUPLICATION,
        'Bundler/InsecureProtocolSource' => Category::SECURITY,
        'Metrics/LineLength' => Category::STYLE,
        'Migrations/RemoveIndex' => Category::PERFORMANCE
      }.freeze

      COMMON_MATCH_TABLE = {
        'Security' => Category::SECURITY,
        'Metrics' => Category::COMPLEXITY,
        'Performance' => Category::PERFORMANCE
      }.freeze

      def self.find_category(cop_name)
        return SPECIFIC_MATCH_TABLE[cop_name] if SPECIFIC_MATCH_TABLE.key?(cop_name)

        cop_module = cop_name.split('/')[0]
        return COMMON_MATCH_TABLE[cop_module] if COMMON_MATCH_TABLE.key?(cop_module)

        Category::STYLE
      end
    end
  end
end
