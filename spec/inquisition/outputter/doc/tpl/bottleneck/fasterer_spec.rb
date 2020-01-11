RSpec.describe Inquisition::Outputter::Doc::TPL::Bottleneck::Fasterer do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new([]) }
  end

  describe '.call' do
    let(:issue) { instance_double(Inquisition::Issue) }
    let(:collector) { instance_double(Inquisition::Outputter::Doc::TPL::Security::Collector) }

    before do
      allow(Inquisition::Outputter::Doc::TPL::Security::Collector).to receive(:new).and_return(collector)
      allow(collector).to receive(:call).and_return([issue])
      allow(described_class).to receive(:new)

      described_class.call([issue])
    end

    it do
      expect(Inquisition::Outputter::Doc::TPL::Security::Collector).to have_received(:new)
        .with([issue], ::Inquisition::Fasterer::Runner)
    end

    it { expect(described_class).to have_received(:new) }
  end

  describe Inquisition::Outputter::Doc::TPL::Bottleneck::Fasterer::Wrapper do
    describe '#group' do
      subject(:wrapper) { described_class.new([issue]) }

      let(:issue) do
        Inquisition::Issue.new(
          path: 'app/controllers/application_controller.rb',
          line: 6,
          severity: Inquisition::Severity::LOW,
          category: Inquisition::Category::PERFORMANCE,
          message: 'Using tr is faster than gsub',
          runner: Inquisition::Fasterer::Runner,
          context: :rescue_vs_respond_to
        )
      end

      let(:explenation) do
        {
          link: (described_class::PATH + 'beginrescue-vs-respond_to-for-control-flow-code'),
          title: 'begin...rescue vs respond_to?'
        }
      end

      it do
        expect do |block|
          wrapper.group(&block)
        end.to yield_with_args(explenation, 1)
      end
    end
  end
end
