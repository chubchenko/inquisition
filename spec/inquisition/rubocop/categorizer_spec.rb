RSpec.describe Inquisition::Rubocop::Categorizer do
  describe '#find_category' do
    subject { described_class.find_category(cop_name) == category }

    context 'when offence category is security' do
      let(:cop_name) { 'Security/Eval' }
      let(:category) { Inquisition::Category::SECURITY }

      it { is_expected.to be_truthy }
    end

    context 'when offence category is duplication' do
      let(:cop_name) { 'Bundler/DuplicatedGem' }
      let(:category) { Inquisition::Category::DUPLICATION }

      it { is_expected.to be_truthy }
    end

    context 'when offence category is style' do
      let(:cop_name) { 'Metrics/LineLength' }
      let(:category) { Inquisition::Category::STYLE }

      it { is_expected.to be_truthy }
    end

    context 'when offence category is performance' do
      let(:cop_name) { 'Migrations/RemoveIndex' }
      let(:category) { Inquisition::Category::PERFORMANCE }

      it { is_expected.to be_truthy }
    end

    context 'when offence category is complexity' do
      let(:cop_name) { 'Metrics/BlockLength' }
      let(:category) { Inquisition::Category::COMPLEXITY }

      it { is_expected.to be_truthy }
    end
  end
end
