RSpec.describe 'inquisition:run' do
  let(:collector) { instance_double(Inquisition::Collector) }

  before do
    allow(collector).to receive(:call)
    allow(Inquisition::Collector).to receive(:new).and_return(collector)
  end

  include_context 'rake' do
    before { task.invoke }

    it { expect(collector).to have_received(:call).once }
  end
end
