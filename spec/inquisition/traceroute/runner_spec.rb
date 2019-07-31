RSpec.describe Inquisition::Traceroute::Runner do
  let(:runner) { described_class.new }
  let(:traceroute) { instance_double(Traceroute) }
  let(:unused_route) { 'foo#bar' }
  let(:unreachable_action) { 'bar#baz' }

  let(:unused_route_issue) do
    { level: Inquisition::Issue::LEVELS[:low], message: "unused route: #{unused_route}" }
  end

  let(:unreachable_action_issue) do
    { level: Inquisition::Issue::LEVELS[:low], message: "unreachable action method: #{unreachable_action}" }
  end

  let(:issues) { [unused_route_issue, unreachable_action_issue] }

  describe '#call' do
    it 'returns array with issues' do
      expect(runner).to receive(:load_environment).and_return(true)
      expect(Traceroute).to receive(:new).and_return(traceroute)
      expect(traceroute).to receive(:load_everything!)
      expect(runner).to receive(:unused_routes).and_return([unused_route])
      expect(runner).to receive(:unreachable_action_methods).and_return([unreachable_action])
      runner.call.each_with_index do |issue, index|
        expect(issue.instance_variable_get(:@level)).to eq(issues[index][:level])
        expect(issue.instance_variable_get(:@message)).to eq(issues[index][:message])
      end
    end
  end
end
