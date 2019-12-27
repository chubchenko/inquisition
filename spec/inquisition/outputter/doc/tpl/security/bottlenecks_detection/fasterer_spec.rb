RSpec.describe Inquisition::Outputter::Doc::TPL::Security::BottlenecksDetection::Fasterer do
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

  describe Inquisition::Outputter::Doc::TPL::Security::BottlenecksDetection::Fasterer::Wrapper do
    describe '#group' do
      subject(:wrapper) do
        described_class.new([issue])
      end

      let(:issue) do
        Inquisition::Issue.new(
          path: nil,
          line: nil,
          severity: Inquisition::Severity::HIGH,
          category: Inquisition::Category::SECURITY,
          message: 'Using tr is faster than gsub',
          runner: nil,
          context: :rescue_vs_respond_to
        )
      end

      let(:explenations) do
        {
          rescue_vs_respond_to: {
            link: (described_class::PATH + 'beginrescue-vs-respond_to-for-control-flow-code').freeze,
            title: 'begin...rescue vs respond_to?'
          }
        }
      end
      let(:test_link) { 'https://github.com/JuanitoFatas/fast-ruby#' }

      before do
        stub_const("#{described_class}::EXPLENATIONS", explenations)
        stub_const("#{described_class}::PATH", test_link)
      end

      it do
        expect do |block|
          wrapper.group(&block)
        end.to yield_with_args(explenations[:rescue_vs_respond_to], 1)
      end
    end
  end
end
