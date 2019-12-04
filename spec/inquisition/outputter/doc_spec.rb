RSpec.describe Inquisition::Outputter::Doc do
  subject(:documentation) { described_class.new(nil) }

  describe '#stop' do
    let(:current_time) { Time.now.strftime('%d_%m_%Y') }
    let!(:directory) { Inquisition::Configuration.instance.output_path }
    let(:full_file_name) { "/Dummy_#{current_time}.docx" }

    before do
      Inquisition::Configuration.instance.loader.add(documentation)
      Inquisition::Configuration.instance.fanout.around do
        []
      end
    end

    after { FileUtils.rm_rf(Dir[directory + full_file_name]) }

    it 'creates a docx file' do
      expect(File).to exist(directory + full_file_name)
    end
  end
end
