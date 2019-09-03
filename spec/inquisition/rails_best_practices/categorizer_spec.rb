RSpec.describe Inquisition::RailsBestPractices::Categorizer do
  describe '.find_category' do
    Inquisition::Category::NAMES.each do |issue_category|
      it "returns #{issue_category} issue category for specific error type" do
        Inquisition::RailsBestPractices::Categorizer::MATCH_TABLE[issue_category].each do |error_type|
          expect(described_class.find_category(error_type)).to eq(issue_category)
        end
      end
    end
  end
end
