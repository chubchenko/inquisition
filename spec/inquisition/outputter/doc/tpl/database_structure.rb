RSpec.describe Inquisition::Outputter::Doc::TPL::DatabaseStructure do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new([]) }
  end

  describe '#active_record_doctor' do
    subject(:database_structure) { described_class.new([]) }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      database_structure.active_record_doctor
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::DatabaseStructure::ActiveRecordDoctor)
      )
    end
  end
end
