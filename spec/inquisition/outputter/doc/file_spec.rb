RSpec.describe Inquisition::Outputter::Doc::File do
  subject(:file) { described_class.new }

  describe '#path' do
    it 'returns file path' do
      expect(file.path).to eq(
        Pathname(File.join(Inquisition::Configuration.instance.output_path, 'DUMMY.docx'))
      )
    end
  end
end
