RSpec.describe Inquisition::Outputter::Doc::TPL::Stack::Collector do
  describe '#call' do
    subject(:call) { described_class.new([gem]).call }

    let(:gem) { 'sidekiq' }
    let(:homepage) { 'test' }
    let(:stub) { double('Bundler::StubSpecification', name: gem, homepage: homepage) }
    let(:bundler_runtime) { instance_double('Bundler::Runtime', specs: { gem => stub }) }
    let(:struct) { double(OpenStruct, name: gem, homepage: homepage) }

    before do
      stub_const('RUBY_PLATFORM', 'x86_64-linux')
      allow(Bundler).to receive(:load).and_return(bundler_runtime)
      allow(OpenStruct).to receive(:new).with(name: gem, homepage: homepage).and_return(struct)
      allow(bundler_runtime.specs).to receive(:find_by_name_and_platform).with(gem, RUBY_PLATFORM).and_return(stub)
      call
    end

    it 'returns OpenStruct data' do
      expect(call).to contain_exactly(struct)
    end
  end
end
