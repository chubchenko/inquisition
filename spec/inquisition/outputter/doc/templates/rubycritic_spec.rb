RSpec.describe Inquisition::Outputter::Doc::Templates::Rubycritic do
  describe '#group_smells_with_difficulties' do
    subject(:group_smells_with_difficulties) { described_class.new(issues).group_smells_with_difficulties }

    let(:issues) { [rubycritic_issue_low, rubycritic_issue_high] }
    let(:runner) { instance_double(Inquisition::Rubycritic::Runner) }
    let(:warning_test) { instance_double('RubyCritic::Smell', type: 'test') }
    let(:warning_args) { instance_double('RubyCritic::Smell', type: 'args') }
    let(:badge) { instance_double('Inquisition::Badge', name: 'rubycritic') }
    let(:severity_low) { instance_double(Inquisition::Severity, name: :low) }
    let(:severity_high) { instance_double(Inquisition::Severity, name: :high) }
    let(:rubycritic_issue_low) do
      instance_double(Inquisition::Issue, aditional_data: warning_args, runner: runner, severity: severity_low)
    end
    let(:rubycritic_issue_high) do
      instance_double(Inquisition::Issue, aditional_data: warning_test, runner: runner, severity: severity_high)
    end
    let(:result_method_call) do
      { low: { 'args' => [rubycritic_issue_low] }, high: { 'test' => [rubycritic_issue_high] } }
    end

    before { allow(Inquisition::Badge).to receive(:for).and_return(badge) }

    it 'returns grouped issues brakeman by warning' do
      expect(group_smells_with_difficulties).to eq(result_method_call)
    end
  end

  describe '#common_smells_score' do
    subject(:common_smells_score) { described_class.new(issues).common_smells_score }

    context 'when method returns common score from runner' do
      let(:issues) { [rubycritic_issue] }
      let(:score) { 100 }
      let(:rubycritic_issue) { instance_double(Inquisition::Issue, runner: runner) }
      let(:runner) { instance_double(Inquisition::Rubycritic::Runner, common_score: score) }
      let(:badge) { instance_double('Inquisition::Badge', name: 'rubycritic') }

      before { allow(Inquisition::Badge).to receive(:for).and_return(badge) }

      it 'returns grouped issues brakeman by warning' do
        expect(common_smells_score).to eq(score)
      end
    end

    context 'when method returns common score without issues' do
      let(:issues) { [] }

      it 'returns grouped issues brakeman by warning' do
        expect(common_smells_score).to eq(described_class::MIN_SCORE)
      end
    end
  end
end
