RSpec.describe Inquisition::Outputter::Doc::Templates::BottlenecksDetection do
  describe '#group_fasterer_by_offense' do
    subject(:group_fasterer_by_offense) { described_class.new(issues).group_fasterer_by_offense }

    let(:issues) { [fasterer_issue, fasterer_issue_first] }
    let(:fasterer_issue) { instance_double(Inquisition::Issue, aditional_data: offense, runner: fasterer_runner) }
    let(:fasterer_issue_first) { instance_double(Inquisition::Issue, aditional_data: offense, runner: fasterer_runner) }
    let(:result_method_call) { { 'test' => [fasterer_issue, fasterer_issue_first] } }
    let(:fasterer_runner) { instance_double(Inquisition::Fasterer::Runner) }
    let(:offense) { instance_double('Fasterer::Offense', offense_name: 'test') }
    let(:badge) { instance_double('Inquisition::Badge', name: 'fasterer') }

    before { allow(Inquisition::Badge).to receive(:for).and_return(badge) }

    it 'returns grouped issues fasterer by offense name' do
      expect(group_fasterer_by_offense).to eq(result_method_call)
    end
  end

  describe '#link_to_offense_error' do
    subject(:link_to_offense_error) { described_class.new.link_to_offense_error(offense_name) }

    let(:offense_name) { :sort_vs_sort_by }
    let(:params_const) { { path: 'test', links: { sort_vs_sort_by: 'test1' } } }
    let(:result_method_call) { params_const[:path] + params_const[:links][:sort_vs_sort_by] }

    before { stub_const('Inquisition::Outputter::Doc::TechnologyStack::FASTERER_ISSUE_LINKS', params_const) }

    it 'returns full path link for error' do
      expect(link_to_offense_error).to eq(result_method_call)
    end
  end
end
