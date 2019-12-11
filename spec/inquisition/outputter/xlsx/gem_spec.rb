require 'pry'
include Helpers::GemInfoHelper

RSpec.describe Inquisition::Outputter::Xlsx::Gem do
  describe '#call' do
    subject(:info_subject) { described_class.new(info) }

    describe 'status value' do
      context 'when current version less than latest version' do
        let(:info) { gem_info(outdated: true) }

        it 'build rails outdated info' do
          expect(info_subject.status).to eq(Inquisition::Outputter::Xlsx::Gem::OUTDATED)
        end
      end
    end

    describe 'environment value' do
      context 'when gem in default group' do
        let(:info) { gem_info(default_group: true) }

        before { allow(::Gem::Dependency).to receive(:groups) { [:default] } }

        it 'match hash structure' do
          expect(info_subject.environment).to eq('')
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
