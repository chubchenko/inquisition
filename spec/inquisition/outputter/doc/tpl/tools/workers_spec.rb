RSpec.describe Inquisition::Outputter::Doc::TPL::Tools::Workers do
  before do
    stub_const("#{described_class}::WORKERS", workers_const)
  end

  describe '#workers' do
    subject(:workers) do
      described_class.new.workers do |gem|
        "#{gem.homepage}, #{gem.name}, #{gem.description}"
      end
    end

    let(:workers_const) do
      { gems: ['sidekiq'], exception: 'test_exception' }
    end
    let(:bundler_runtime) { instance_double('Bundler::Runtime', specs: { workers_const[:gems].first => stub }) }
    let(:stub) { [double('Bundler::StubSpecification', name: workers_const[:gems].first, homepage: test_homepage)] }
    let(:test_homepage) { 'test_homepage' }
    let(:struct) do
      OpenStruct.new(name: workers_const[:gems].first,
                     homepage: test_homepage,
                     description: '')
    end

    before do
      allow(OpenStruct).to receive(:new).and_return(struct)
      allow(Bundler).to receive(:load).and_return(bundler_runtime)
      workers
    end

    it 'returns instance struct with params' do
      expect(OpenStruct).to have_received(:new).with(name: workers_const[:gems].first,
                                                     homepage: test_homepage,
                                                     description: '')
    end
  end

  describe '#trouble' do
    subject(:trouble) do
      described_class.new.trouble do |exception|
        exception
      end
    end

    let(:workers_const) { { gems: ['sidekiq'], exception: 'test_exception' } }

    context 'when gem exists' do
      let(:specs) { { 'sidekiq' => [] } }

      before { allow(Gem).to receive(:loaded_specs).and_return(specs) }

      it 'returns empty array' do
        expect(trouble).to be_empty
      end
    end

    context 'when gem not exists exists' do
      let(:specs) { {} }

      before { allow(Gem).to receive(:loaded_specs).and_return(specs) }

      it 'returns empty array' do
        expect(trouble).to eq(workers_const[:exception])
      end
    end
  end
end
