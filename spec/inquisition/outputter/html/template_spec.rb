RSpec.describe Inquisition::Outputter::HTML::Template do
  describe '#render' do
    subject(:template) { described_class.new('issues') }

    let(:erb) { instance_double(ERB) }
    let(:binding) { instance_double(Binding) }
    let(:context) { instance_double(Inquisition::Outputter::HTML::Issues) }

    before do
      allow(context).to receive(:produce).and_return(binding)
      allow(erb).to receive(:result).and_return('')
      allow(ERB).to receive(:new).and_return(erb)
    end

    it 'produces template' do
      template.render(context)

      expect(erb).to have_received(:result).with(binding)
    end
  end
end
