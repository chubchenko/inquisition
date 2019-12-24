RSpec.describe Inquisition::Outputter::Doc::TPL::Security::PatchLevel do
  include_examples 'produce', described_class.new([])

  describe '.call' do
    let(:issue) do
      Inquisition::Issue.new(
        category: Inquisition::Category::SECURITY,
        path: 'app/controllers/users_controller.rb',
        line: 42,
        severity: Inquisition::Severity::HIGH,
        message: 'Potentially dangerous key allowed for mass assignment',
        context: 'Cross-Site Scripting',
        runner: Inquisition::Bundler::Audit::Runner.new
      )
    end
    let(:collector) { instance_double(Inquisition::Outputter::Doc::TPL::Security::Collector) }
    let(:wrapper) { instance_double(described_class::Wrapper) }

    before do
      allow(described_class::Wrapper).to receive(:new).and_return(wrapper)
      allow(described_class).to receive(:new)

      described_class.call([issue])
    end

    it do
      expect(described_class::Wrapper).to have_received(:new).with(
        [issue]
      )
    end

    it { expect(described_class).to have_received(:new).with(wrapper) }
  end

  describe Inquisition::Outputter::Doc::TPL::Security::PatchLevel::Wrapper do
    subject(:wrapper) { described_class.new([issue, issue]) }

    let(:gem) { instance_double(Bundler::LazySpecification, name: 'test') }
    let(:stub) { double(Bundler::StubSpecification, homepage: 'test') }
    let(:struct) { double(OpenStruct, name: gem.name, homepage: stub.homepage) }
    let(:result) { { struct => [issue, issue] } }
    let(:issue) do
      Inquisition::Issue.new(
        category: Inquisition::Category::SECURITY,
        path: 'app/controllers/users_controller.rb',
        line: 42,
        severity: Inquisition::Severity::HIGH,
        message: 'Potentially dangerous key allowed for mass assignment',
        context: gem,
        runner: Inquisition::Bundler::Audit::Runner.new
      )
    end

    before do
      allow(OpenStruct).to receive(:new).with(name: gem.name, homepage: stub.homepage).and_return(struct)
      allow(gem).to receive(:__materialize__).and_return(stub)
    end

    describe '#group' do
      it { expect(wrapper.group).to eq(result) }
    end
  end
end
