RSpec.describe Inquisition::Traceroute::Runner do
  include_examples 'enablable', 'traceroute'

  describe '#call' do
    subject(:runner) { described_class.new }

    let(:traceroute) { instance_double(Traceroute) }

    before do
      allow(traceroute).to receive(:load_everything!)
      allow(Traceroute).to receive(:new).and_return(traceroute).with(Rails.application).and_return(traceroute)
    end

    context 'when there are no issues' do
      before do
        allow(traceroute).to receive(:routed_actions).and_return([])
        allow(traceroute).to receive(:defined_action_methods).and_return([])
      end

      it { expect(runner.call).to be_empty }
    end

    context 'when there is one unused route' do
      let(:issue) do
        Inquisition::Issue.new(
          path: nil,
          line: nil,
          severity: :low,
          category: :unused_code,
          message: 'Unused route: users#index',
          runner: runner
        )
      end

      before do
        allow(traceroute).to receive(:routed_actions).and_return(['users#index'])
        allow(traceroute).to receive(:defined_action_methods).and_return([])
      end

      it 'returns a collection of issues' do
        expect(runner.call).to contain_exactly(issue)
      end
    end

    context 'when there is one unreachable action method' do
      let(:issue) do
        Inquisition::Issue.new(
          path: nil,
          line: nil,
          severity: :low,
          category: :unused_code,
          message: 'Unreachable action method: users#index2',
          runner: runner
        )
      end

      before do
        allow(traceroute).to receive(:routed_actions).and_return([])
        allow(traceroute).to receive(:defined_action_methods).and_return(['users#index2'])
      end

      it 'returns a collection of issues' do
        expect(runner.call).to contain_exactly(issue)
      end
    end
  end
end
