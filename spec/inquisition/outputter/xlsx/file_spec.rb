RSpec.describe Inquisition::Outputter::Xlsx::File do
  subject(:file) { described_class.new }

  describe '#path' do
    it 'returns file path' do
      filename = "dummy_#{Time.current.strftime('%d_%m_%y')}"
      expect(file.path).to eq(
        Pathname(File.join(Inquisition::Configuration.instance.output_path, filename + '.xlsx'))
      )
    end
  end
end
