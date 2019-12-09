RSpec.describe Inquisition::Outputter::Xlsx::File do
  subject(:file) { described_class.new }

  describe '#path' do
    it 'returns file path' do
      expect(file.path).to eq(
        Pathname(File.join(Inquisition::Configuration.instance.output_path, 'DUMMY.xlsx'))
      )
    end
  end
end
