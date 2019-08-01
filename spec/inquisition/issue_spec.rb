RSpec.describe Inquisition::Issue do
  describe '.new' do
    context 'when the unknown level is passed' do
      it do
        expect do
          described_class.new(level: 'unknown', file: nil, line: nil, message: nil, runner: nil)
        end.to raise_error(ArgumentError, 'Unknown level: unknown')
      end
    end
  end

  describe '#==' do
    subject { issue == other }

    let(:issue) do
      described_class.new(
        level: 'high',
        file: 'show.html.erb',
        line: '10',
        message: 'Unescaped parameter value',
        runner: nil
      )
    end

    context 'when a level, message, file and line match' do
      let(:other) do
        described_class.new(
          level: issue.level, file: issue.file, line: issue.line, message: issue.message, runner: nil
        )
      end

      it { is_expected.to be_truthy }
    end

    context 'when at least one of the comparison attributes does not match' do
      let(:other) do
        described_class.new(
          level: 'high',
          file: 'show.html.erb',
          line: '11',
          message: 'Unescaped parameter value',
          runner: nil
        )
      end

      it { is_expected.to be_falsy }
    end
  end

  describe '#hash' do
    subject { issue.hash == other.hash }

    let(:issue) do
      described_class.new(
        level: 'high',
        file: '_slimmer.html.slim',
        line: '6',
        message: 'Unescaped parameter value',
        runner: nil
      )
    end

    context 'when a level, message, file and line match' do
      let(:other) do
        described_class.new(level: issue.level, file: issue.file, line: issue.line, message: issue.message, runner: nil)
      end

      it { is_expected.to be_truthy }
    end

    context 'when at least one of the comparison attributes does not match' do
      let(:other) do
        described_class.new(
          level: 'high',
          file: '_slimmer.html.slim',
          line: '7',
          message: 'Unescaped parameter value',
          runner: nil
        )
      end

      it { is_expected.to be_falsy }
    end
  end
end
