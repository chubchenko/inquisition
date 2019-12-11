RSpec.describe Inquisition::Issue do
  describe '#==' do
    subject { issue == other }

    let(:issue) do
      described_class.new(
        severity: Inquisition::Severity::HIGH,
        category: Inquisition::Category::STYLE,
        path: 'show.html.erb',
        line: '10',
        message: 'Unescaped parameter value',
        runner: nil,
        aditional_data: nil
      )
    end

    context 'when a severity, message, path, category and line match' do
      let(:other) do
        described_class.new(
          severity: issue.severity.name,
          category: issue.category.name,
          path: issue.path,
          line: issue.line,
          message: issue.message,
          runner: nil,
          aditional_data: nil
        )
      end

      it { is_expected.to be_truthy }
    end

    context 'when at least one of the comparison attributes does not match' do
      let(:other) do
        described_class.new(
          severity: Inquisition::Severity::HIGH,
          category: Inquisition::Category::STYLE,
          path: 'show.html.erb',
          line: '11',
          message: 'Unescaped parameter value',
          runner: nil,
          aditional_data: nil
        )
      end

      it { is_expected.to be_falsy }
    end
  end

  describe '#hash' do
    subject { issue.hash == other.hash }

    let(:issue) do
      described_class.new(
        severity: Inquisition::Severity::HIGH,
        category: Inquisition::Category::STYLE,
        path: '_slimmer.html.slim',
        line: '6',
        message: 'Unescaped parameter value',
        runner: nil,
        aditional_data: nil
      )
    end

    context 'when a severity, message, path, category and line match' do
      let(:other) do
        described_class.new(
          severity: issue.severity.name,
          category: issue.category.name,
          path: issue.path,
          line: issue.line,
          message: issue.message,
          runner: nil,
          aditional_data: nil
        )
      end

      it { is_expected.to be_truthy }
    end

    context 'when at least one of the comparison attributes does not match' do
      let(:other) do
        described_class.new(
          severity: Inquisition::Severity::HIGH,
          category: Inquisition::Category::STYLE,
          path: '_slimmer.html.slim',
          line: '7',
          message: 'Unescaped parameter value',
          runner: nil,
          aditional_data: nil
        )
      end

      it { is_expected.to be_falsy }
    end
  end
end
