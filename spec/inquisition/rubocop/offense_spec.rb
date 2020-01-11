RSpec.describe Inquisition::Rubocop::Offense do
  let(:offense) { described_class.new(registry, config, {}).offenses(processed_source) }

  let(:config) { instance_double(RuboCop::Config) }
  let(:registry) { instance_double(RuboCop::Cop::Registry) }
  let(:processed_source) { instance_double(RuboCop::ProcessedSource) }

  it { expect(described_class).to be < RuboCop::Cop::Team }

  describe '#offenses' do
    before { allow(registry).to receive(:enabled).and_return([]) }

    context 'when valid_syntax? for processed_source returns true' do
      it 'returns offenses' do
        expect(offense).to be_empty
      end
    end
  end
end
