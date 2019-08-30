RSpec.describe Inquisition::Rubocop::Issue do
  describe '#to_h' do
    subject(:issue) { described_class.new(file, offense) }

    let(:file) { 'test/file.rb' }
    let(:line) { 1 }
    let(:message) { 'test message' }

    let(:offense) do
      instance_double(
        RuboCop::Cop::Offense,
        severity: rubocop_severity,
        message: message,
        line: line,
        cop_name: 'Security/Eval'
      )
    end

    let(:options) do
      {
        severity: inquisition_severity,
        message: message,
        path: file,
        line: line,
        category: Inquisition::Category::SECURITY
      }
    end

    context 'when offence severity name is convention' do
      let(:rubocop_severity) { instance_double(RuboCop::Cop::Severity, name: :convention) }
      let(:inquisition_severity) { Inquisition::Severity::LOW }

      it { expect(issue.to_h).to include(options) }
    end

    context 'when offence severity name is refactor' do
      let(:rubocop_severity) { instance_double(RuboCop::Cop::Severity, name: :refactor) }
      let(:inquisition_severity) { Inquisition::Severity::LOW }

      it { expect(issue.to_h).to include(options) }
    end

    context 'when offence severity name is warning' do
      let(:rubocop_severity) { instance_double(RuboCop::Cop::Severity, name: :warning) }
      let(:inquisition_severity) { Inquisition::Severity::MEDIUM }

      it { expect(issue.to_h).to include(options) }
    end

    context 'when offence severity name is error' do
      let(:rubocop_severity) { instance_double(RuboCop::Cop::Severity, name: :error) }
      let(:inquisition_severity) { Inquisition::Severity::HIGH }

      it { expect(issue.to_h).to include(options) }
    end

    context 'when offence severity name is fatal' do
      let(:rubocop_severity) { instance_double(RuboCop::Cop::Severity, name: :fatal) }
      let(:inquisition_severity) { Inquisition::Severity::HIGH }

      it { expect(issue.to_h).to include(options) }
    end
  end
end
