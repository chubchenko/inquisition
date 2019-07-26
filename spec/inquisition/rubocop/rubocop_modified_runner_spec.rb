RSpec.describe Inquisition::RuboCop::RuboCopModifiedRunner do
  let(:runner) { described_class.new(nil, nil) }

  describe '#initialize' do
    it 'creates empty array for issues during initialization' do
      expect(runner.instance_variable_get(:@issues)).to eq([])
    end
  end

  describe '#run' do
    let(:file) { 'file' }
    let(:target_files) { [file] }
    let(:issues) { ['issue file', ['issue body']] }
    let(:offense) { instance_double(RuboCop::Cop::Offense) }
    let(:offenses) { [[file, [offense]]] }

    before do
      expect(runner).to receive(:find_target_files).and_return(target_files)
      expect(runner).to receive(:file_offenses).with(file).and_return([offense])
      expect(offense).to receive(:disabled?).and_return([offense])
      expect(runner).to receive(:file_started).with(file)
    end

    it 'returns offenses' do
      expect(runner.run(['.'])).to eq(offenses)
    end
  end
end
