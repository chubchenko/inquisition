RSpec.describe Inquisition::Outputter::Doc::Templates::Brakeman do
  describe '#group_brakeman_issues_by_warnings' do
    subject(:group_brakeman_issues_by_warnings) { described_class.new(issues).group_brakeman_issues_by_warnings }

    let(:issues) { [brakeman_issue, brakeman_issue_first] }
    let(:brakeman_issue) { instance_double(Inquisition::Issue, aditional_data: warning, runner: brakeman_runner) }
    let(:brakeman_issue_first) { instance_double(Inquisition::Issue, aditional_data: warning, runner: brakeman_runner) }
    let(:result_method_call) { { 'test' => [brakeman_issue, brakeman_issue_first] } }
    let(:brakeman_runner) { instance_double(Inquisition::Brakeman::Runner) }
    let(:warning) { instance_double('Brakeman::Warning', warning_type: 'test') }
    let(:badge) { instance_double('Inquisition::Badge', name: 'brakeman') }

    before { allow(Inquisition::Badge).to receive(:for).and_return(badge) }

    it 'returns grouped issues brakeman by warning' do
      expect(group_brakeman_issues_by_warnings).to eq(result_method_call)
    end
  end
end
