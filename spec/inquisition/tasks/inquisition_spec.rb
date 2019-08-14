RSpec.describe 'inquisition:run' do
  let(:collector) { instance_double(Inquisition::Collector) }
  let(:formatter) { instance_double(Inquisition::Formatters::HtmlFormatter) }
  let(:collection) { [instance_double(Inquisition::Issue)] }

  before do
    allow(collector).to receive(:call).and_return(collection)
    allow(Inquisition::Collector).to receive(:new).and_return(collector)
    allow(formatter).to receive(:call)
    allow(Inquisition::Formatters::HtmlFormatter).to receive(:new).with(collection).and_return(formatter)
  end

  include_context 'rake' do
    before { task.invoke }

    it do
      expect(collector).to have_received(:call).once
      expect(formatter).to have_received(:call).once
    end
  end
end
