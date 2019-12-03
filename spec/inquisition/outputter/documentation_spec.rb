RSpec.describe Inquisition::Outputter::Documentation do
  let(:documentation) { described_class.new(nil) }

  describe '#generate_doc' do
    let(:current_time) { Time.now.strftime('%d_%m_%Y') }
    let(:directory) { Rails.root.to_s + '/inquisition' }
    let(:full_file_name) { "/Dummy_#{current_time}.docx" }

    before { documentation }

    after { FileUtils.rm_rf(Dir[directory + full_file_name]) }

    it 'creates a docx file' do
      expect(File.exist?(directory + full_file_name)).to be true
    end
  end
end
