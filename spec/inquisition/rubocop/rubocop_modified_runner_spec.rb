RSpec.describe Inquisition::Rubocop::RuboCopModifiedRunner do
  let(:runner) { described_class.new(nil, nil) }

  describe '#initialize' do
    it 'creates empty array for issues during initialization' do
      expect(runner.issues).to eq([])
    end
  end

  describe '#run' do
    let(:file) { 'app/controllers/application_controller.rb' }
    let(:target_files) { ["#{Rails.root}/#{file}"] }
    let(:issues) { ['issue file', ['issue body']] }
    let(:offense) { instance_double(RuboCop::Cop::Offense) }
    let(:offenses) { [{file => [offense]}] }

    before do
      allow(runner).to receive(:find_target_files).and_return(target_files)
      allow(runner).to receive(:file_offenses).with("#{Rails.root}/#{file}").and_return([offense])
      allow(offense).to receive(:disabled?).and_return([offense])
      allow(runner).to receive(:file_started).with("#{Rails.root}/#{file}")
    end

    it 'returns offenses' do
      expect(runner.run([Rails.root])).to eq(offenses)
      expect(runner).to have_received(:find_target_files)
      expect(runner).to have_received(:file_offenses).with("#{Rails.root}/#{file}")
      expect(offense).to have_received(:disabled?)
      expect(runner).to have_received(:file_started).with("#{Rails.root}/#{file}")
    end
  end
end
