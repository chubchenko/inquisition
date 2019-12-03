RSpec.describe Inquisition::Outputter::Doc do
  let(:documentation) { described_class.new(nil) }

  describe '#generate_doc' do
    let(:current_time) { Time.now.strftime('%d_%m_%Y') }
    let(:directory) { Rails.root.to_s + '/inquisition' }
    let(:full_file_name) { "/Dummy_#{current_time}.docx" }

    before { documentation.generate_doc(nil) }

    after { FileUtils.rm_rf(Dir[directory + full_file_name]) }

    it 'creates a docx file' do
      expect(File.exist?(directory + full_file_name)).to be true
    end
  end

  describe '#stop' do
    before do
      Inquisition::Configuration.instance.loader.add(documentation)
      allow(documentation).to receive(:generate_doc)
      Inquisition::Configuration.instance.fanout.around do
        %w[a b c]
      end
    end

    it do
      expect(documentation).to have_received(:generate_doc).with(%w[a b c])
    end
  end
end
