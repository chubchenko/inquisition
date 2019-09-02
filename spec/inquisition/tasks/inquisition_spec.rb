RSpec.describe 'inquisition' do
  before { allow(Inquisition::Collector).to receive(:invoke) }

  include_context 'rake' do
    before { task.invoke }

    it { expect(Inquisition::Collector).to have_received(:invoke).once }
  end
end
