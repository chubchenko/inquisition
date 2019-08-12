RSpec.describe Inquisition::Collector do
  subject(:result) { collector.call }

  before { allow(collector).to receive(:print) }

  describe '#call' do
    context 'when there are no runners' do
      let(:collector) { described_class.new(collection: []) }

      it { is_expected.to be_empty }
    end

    context 'when there is at least 1 runner' do

      let(:collector) { described_class.new(collection: [dummy]) }
      let(:dummy) do
        Class.new do
          def call
            ['a', %w[b c]]
          end

          def self.enabled?
            true
          end
        end
      end

      it do
        is_expected.to match_array(%w[a b c])
      end
    end

    context 'when the runner is disabled' do
      let(:collector) { described_class.new(collection: [dummy]) }

      let(:dummy) do
        Class.new do
          def call
            ['a', %w[b c]]
          end

          def self.enabled?
            false
          end
        end
      end

      it { is_expected.to be_empty }
    end
  end
end
