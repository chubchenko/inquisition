RSpec.describe Inquisition::Outputter::Xlsx::GemsInfo do
  describe '#call' do
    subject(:info_subject) { described_class.new.call }
    let(:gem_info) { info_subject.detect { |info| info[:name] == gem_name } }

    describe 'status value' do
      context 'when current version less than latest version' do
        let(:gem_name) { 'rails' }

        it 'build rails outdated info' do
          expect(gem_info[:status]).to eq(Inquisition::Outputter::Xlsx::GemsInfo::OUTDATED)
        end
      end
    end

    describe 'environment value' do
      context 'when gem in default group' do
        let(:gem_name) { 'puma' }

        it 'match hash structure' do
          expect(gem_info[:environment]).to eq('')
        end
      end

      context 'when gem in development group' do
        let(:gem_name) { 'simplecov' }

        it 'match hash structure' do
          expect(gem_info[:environment]).to eq('development')
        end
      end
    end

    describe 'returned structure' do
      it 'match hash structure' do
        expect(info_subject.first).to include(:name, :homepage, :current_version, :latest_version, :status, :environment)
      end
    end
  end
end
