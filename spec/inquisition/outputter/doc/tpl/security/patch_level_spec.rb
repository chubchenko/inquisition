RSpec.describe Inquisition::Outputter::Doc::TPL::Security::PatchLevel do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new([]) }
  end

  describe '.call' do
    let(:issue) { instance_double(Inquisition::Issue) }
    let(:collector) { instance_double(Inquisition::Outputter::Doc::TPL::Security::Collector) }
    let(:wrapper) { instance_double(Inquisition::Outputter::Doc::TPL::Security::PatchLevel::Wrapper) }

    before do
      allow(Inquisition::Outputter::Doc::TPL::Security::Collector).to receive(:new).and_return(collector)
      allow(collector).to receive(:call).and_return([issue])
      allow(Inquisition::Outputter::Doc::TPL::Security::PatchLevel::Wrapper).to receive(:new).and_return(wrapper)
      allow(described_class).to receive(:new)

      described_class.call([issue])
    end

    it do
      expect(Inquisition::Outputter::Doc::TPL::Security::Collector).to have_received(:new).with(
        [issue], Inquisition::Bundler::Audit::Runner
      )
    end

    it do
      expect(
        Inquisition::Outputter::Doc::TPL::Security::PatchLevel::Wrapper
      ).to have_received(:new).with([issue])
    end

    it do
      expect(
        described_class
      ).to have_received(:new).with(wrapper)
    end
  end

  describe Inquisition::Outputter::Doc::TPL::Security::PatchLevel::Wrapper do
    describe '#group' do
      subject(:wrapper) { described_class.new([issue, issue]) }

      let(:issue) do
        Inquisition::Issue.new(
          path: nil,
          line: nil,
          severity: Inquisition::Severity::HIGH,
          category: Inquisition::Category::SECURITY,
          message: 'Loofah XSS Vulnerability',
          runner: nil,
          context: context
        )
      end
      let(:context) do
        instance_double(Bundler::LazySpecification,
                        name: 'loofah',
                        __materialize__: double(:__materialize__, homepage: 'https://github.com/flavorjones/loofah'))
      end
      let(:gem) do
        OpenStruct.new(name: 'loofah', homepage: 'https://github.com/flavorjones/loofah')
      end

      it { expect(wrapper.group).to eq(gem => [issue, issue]) }
    end
  end
end
