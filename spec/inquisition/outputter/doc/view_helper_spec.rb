RSpec.describe Inquisition::Outputter::Doc::ViewHelper do
  describe '#workers_with_jobs' do
    subject(:workers_with_jobs) { described_class.new.workers_with_jobs }

    before { allow(Gem).to receive(:loaded_specs).and_return(gem_specification) }

    context 'when gems exists in rails app' do
      let(:params_const) { { gems: ['test_name_gem'] } }
      let(:gem_specification) { { 'test_name_gem' => 'object' } }

      before { stub_const('Inquisition::Outputter::Doc::TechnologyStack::WORKERS_WITH_JOBS', params_const) }

      it 'returns exists gem' do
        expect(workers_with_jobs.first).to be_kind_of(Inquisition::Outputter::Doc::GemDetails)
      end
    end

    context 'when gems not exists in rails app' do
      let(:params_const) { { gems: ['test_name_gem'], exception: 'error' } }
      let(:gem_specification) { {} }

      before { stub_const('Inquisition::Outputter::Doc::TechnologyStack::WORKERS_WITH_JOBS', params_const) }

      it 'returns message about not exists gem' do
        expect(workers_with_jobs).to eq([{ exception: 'error' }])
      end
    end
  end
end
