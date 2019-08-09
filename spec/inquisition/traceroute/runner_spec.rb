RSpec.describe Inquisition::Traceroute::Runner do
  let(:runner) { described_class.new }
  let(:traceroute) { instance_double(Traceroute) }
  let(:unused_route) { 'foo#bar' }
  let(:unreachable_action) { 'bar#baz' }

  let(:unused_route_issue) do
    { severity: :low, message: "unused route: #{unused_route}" }
  end

  let(:unreachable_action_issue) do
    { severity: :low, message: "unreachable action method: #{unreachable_action}" }
  end

  let(:issues) { [unused_route_issue, unreachable_action_issue] }

  describe '#call' do
    it 'returns array with issues' do
      expect(Traceroute).to receive(:new).and_return(traceroute)
      expect(traceroute).to receive(:load_everything!)
      expect(runner).to receive(:unused_routes).and_return([unused_route])
      expect(runner).to receive(:unreachable_action_methods).and_return([unreachable_action])
      runner.call.each_with_index do |issue, index|
        # TODO: will be fixed in the next PR
        # expect(issue.instance_variable_get(:@severity)).to eq(issues[index][:severity])
        expect(issue.instance_variable_get(:@message)).to eq(issues[index][:message])
      end
    end
  end

  include_examples 'enablable', 'traceroute'
end
