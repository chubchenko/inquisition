RSpec.describe Inquisition::Traceroute::Runner do
  let(:runner) { described_class.new }
  let(:traceroute) { instance_double(Traceroute) }
  let(:unused_route) { 'foo#bar' }
  let(:unreachable_action) { 'bar#baz' }

  let(:unused_route_issue) do
    { category: :unused_code, severity: :low, message: "unused route: #{unused_route}" }
  end

  let(:unreachable_action_issue) do
    { category: :unused_code, severity: :low, message: "unreachable action method: #{unreachable_action}" }
  end

  let(:issues) { [unused_route_issue, unreachable_action_issue] }

  before do
    allow(runner).to receive(:unused_routes).and_return([unused_route])
    allow(runner).to receive(:unreachable_action_methods).and_return([unreachable_action])
  end

  describe '#call' do
    it 'returns array with issues' do
      runner.call.each_with_index do |issue, index|
        expect(issue.message).to eq(issues[index][:message])
        expect(issue.severity.name).to eq(issues[index][:severity])
        expect(issue.category.name).to eq(issues[index][:category])
      end
    end
  end

  include_examples 'enablable', 'traceroute'
end
