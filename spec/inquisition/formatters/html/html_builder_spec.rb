RSpec.describe Inquisition::Formatters::Html::HtmlBuilder do
  let(:collection) { [instance_double(Inquisition::Issue)] }
  let(:builder) { described_class.new(collection) }

  describe '#render' do
    let(:erb_example) { '<%= 2*2 %>' }
    let(:example_answer) { '4' }

    before do
      allow(builder).to receive(:file_name)
      allow(File).to receive(:read).and_return(erb_example)
    end

    it { expect(builder.render).to eq(example_answer) }
  end

  describe '#file_path' do
    context 'when #file_name exists' do
      let(:file_name) { 'test_name' }

      before { allow(builder).to receive(:file_name).and_return(file_name) }

      it { expect(builder.file_path).to eq("#{Rails.root}/inquisition_report/#{file_name}") }
    end

    context 'when #file_name doesnt exist' do
      it { expect { builder.file_path }.to raise_error(NotImplementedError) }
    end
  end
end
