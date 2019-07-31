RSpec.describe Inquisition::Issue do
  let(:valid_attributes) do
    { level: Inquisition::Issue::LEVELS[:low], runner: 'runner', file: nil, line: nil, message: nil }
  end

  let(:different_runner_attributes) do
    { level: Inquisition::Issue::LEVELS[:low], runner: 'runner_2', file: nil, line: nil, message: nil }
  end

  let(:different_level_attributes) do
    { level: Inquisition::Issue::LEVELS[:high], file: nil, line: nil, runner: nil, message: nil }
  end

  let(:unknown_level_attributes) { { level: 'unknown', file: nil, line: nil, runner: nil, message: nil } }

  let(:valid_issue) { described_class.new(**valid_attributes) }
  let(:different_level_issue) { described_class.new(**different_level_attributes) }
  let(:different_runner_issue) { described_class.new(**different_runner_attributes) }

  context 'when the unknown level is passed' do
    it do
      expect { described_class.new(**unknown_level_attributes) }.to raise_error(ArgumentError, 'Incorrect issue level')
    end
  end

  describe '#eql' do
    subject { valid_issue == other }

    context 'when a level, message, file and line match, and runner does not' do
      let(:other) { different_runner_issue }

      it { is_expected.to be_truthy }
    end

    context 'when at least one of the comparison attributes does not match' do
      let(:other) { different_level_issue }

      it { is_expected.to be_falsy }
    end
  end

  describe '#hash' do
    subject { valid_issue.hash == other.hash }

    context 'when a level, message, file and line match, and runner does not' do
      let(:other) { different_runner_issue }

      it { is_expected.to be_truthy }
    end

    context 'when at least one of the comparison attributes does not match' do
      let(:other) { different_level_issue }

      it { is_expected.to be_falsy }
    end
  end
end
