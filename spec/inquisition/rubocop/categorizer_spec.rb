RSpec.describe Inquisition::Rubocop::Categorizer do
  describe '.find_category' do
    subject { described_class.find_category(cop_name) == category }

    context 'when cop name is Bundler/DuplicatedGem' do
      let(:cop_name) { 'Bundler/DuplicatedGem' }
      let(:category) { :duplication }

      it { is_expected.to be_truthy }
    end

    context 'when cop name is Bundler/InsecureProtocolSource' do
      let(:cop_name) { 'Bundler/InsecureProtocolSource' }
      let(:category) { :security }

      it { is_expected.to be_truthy }
    end

    context 'when cop name is Metrics/LineLength' do
      let(:cop_name) { 'Metrics/LineLength' }
      let(:category) { :style }

      it { is_expected.to be_truthy }
    end

    context 'when cop name is Migrations/RemoveIndex' do
      let(:cop_name) { 'Migrations/RemoveIndex' }
      let(:category) { :performance }

      it { is_expected.to be_truthy }
    end

    context 'when cop name is Security' do
      let(:cop_name) { 'Security' }
      let(:category) { :security }

      it { is_expected.to be_truthy }
    end

    context 'when cop name is Metrics' do
      let(:cop_name) { 'Metrics' }
      let(:category) { :complexity }

      it { is_expected.to be_truthy }
    end

    context 'when cop name is Performance' do
      let(:cop_name) { 'Performance' }
      let(:category) { :performance }

      it { is_expected.to be_truthy }
    end

    context 'when cop name doesnt belong to any category from match tables' do
      let(:cop_name) { 'Foo/Bar' }
      let(:category) { :style }

      it { is_expected.to be_truthy }
    end
  end
end
