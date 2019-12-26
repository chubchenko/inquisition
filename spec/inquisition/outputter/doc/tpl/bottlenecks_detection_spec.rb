RSpec.describe Inquisition::Outputter::Doc::TPL::BottlenecksDetection do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new([]) }
  end

  describe '#active_record_doctor' do
    subject(:security) { described_class.new([]) }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      security.active_record_doctor
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::Security::BottlenecksDetection::ActiveRecordDoctor)
      )
    end
  end

  describe '#fasterer' do
    subject(:security) { described_class.new([]) }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      security.fasterer
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::Security::BottlenecksDetection::Fasterer)
      )
    end
  end

  describe '#lol_dba' do
    subject(:security) { described_class.new([]) }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      security.lol_dba
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::Security::BottlenecksDetection::LolDba)
      )
    end
  end
end
