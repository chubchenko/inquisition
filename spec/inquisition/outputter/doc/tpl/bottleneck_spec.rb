RSpec.describe Inquisition::Outputter::Doc::TPL::Bottleneck do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new([]) }
  end

  describe '#active_record_doctor' do
    subject(:bottleneck) { described_class.new([]) }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      bottleneck.active_record_doctor
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::Bottleneck::ActiveRecordDoctor)
      )
    end
  end

  describe '#fasterer' do
    subject(:bottleneck) { described_class.new([]) }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      bottleneck.fasterer
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::Bottleneck::Fasterer)
      )
    end
  end

  describe '#lol_dba' do
    subject(:bottleneck) { described_class.new([]) }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      bottleneck.lol_dba
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::Bottleneck::LolDba)
      )
    end
  end
end
