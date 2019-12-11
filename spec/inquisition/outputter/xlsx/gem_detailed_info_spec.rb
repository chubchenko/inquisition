include Helpers::GemInfoHelper

RSpec.describe Inquisition::Outputter::Xlsx::GemDetailedInfo do
  subject(:gem_detailed_subject) { described_class.new(info).call }
  let(:info) { gem_info }

  describe '#call' do
    it 'match hash structure' do
      expect(gem_detailed_subject).to include(:detailed_status, :color)
    end
  end
end
