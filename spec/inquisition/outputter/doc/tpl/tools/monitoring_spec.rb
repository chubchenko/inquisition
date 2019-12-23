RSpec.describe Inquisition::Outputter::Doc::TPL::Tools::Monitoring do
  let(:monitoring_const) do
    {
      gems: ['test_one'],
      description: 'test_description',
      exception: 'test_exception'
    }
  end

  before do
    stub_const("#{described_class}::MONITORING_SERVICES", monitoring_const)
    stub_const("#{described_class}::MONITORING_PERFORMANCE_SERVICES", performance_const)
  end

  describe '#monitoring' do
    subject(:monitoring) do
      described_class.new.monitoring do |gem|
        "#{gem.homepage}, #{gem.name}, #{gem.description}"
      end
    end

    let(:performance_const) { { gems: [], description: '', exception: 'test_exception' } }
    let(:bundler_runtime) { instance_double('Bundler::Runtime', specs: { monitoring_const[:gems].first => stub }) }
    let(:stub) { [double('Bundler::StubSpecification', name: monitoring_const[:gems].first, homepage: 'test')] }
    let(:struct) do
      OpenStruct.new(name: monitoring_const[:gems].first,
                     homepage: stub.first.homepage,
                     description: monitoring_const[:exception])
    end
    let(:test_homepage) { 'test_homepage' }

    before do
      allow(OpenStruct).to receive(:new).and_return(struct)
      allow(Bundler).to receive(:load).and_return(bundler_runtime)
      monitoring
    end

    it 'returns instance struct with params' do
      expect(OpenStruct).to have_received(:new).with(name: 'test_one',
                                                     homepage: 'test',
                                                     description: 'test_description')
    end
  end

  describe '#trouble' do
    subject(:trouble) do
      described_class.new.trouble
    end

    let(:performance_const) { { gems: ['test'], description: '', exception: 'test_exception' } }

    context 'when gem exists' do
      let(:specs) { { 'test' => [], 'test_one' => [] } }

      before { allow(Gem).to receive(:loaded_specs).and_return(specs) }

      it 'returns empty array' do
        expect(trouble).to be_empty
      end
    end

    context 'when gem not exists exists' do
      let(:specs) { { 'test_one' => [] } }

      before { allow(Gem).to receive(:loaded_specs).and_return(specs) }

      it 'returns empty array' do
        expect(trouble).to eq([monitoring_const[:exception]])
      end
    end
  end
end
