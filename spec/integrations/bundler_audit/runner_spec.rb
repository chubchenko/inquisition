ENV['RAILS_ENV'] = 'test'
require_relative '../../dummy/config/environment'

RSpec.describe Inquisition::Bundler::Audit::Runner do
  describe '#call' do

    context 'when check errors with bundler-audit scanner' do
      it 'scanner.scan return errors' do
        expect(Inquisition::Issue).to receive(:new).with(
          level: "low",
          line: '',
          runner: be_kind_of(described_class),
          file: "/home/rostik/.local/share/ruby-advisory-db/gems/actionview/CVE-2019-5418.yml",
          message: 'File Content Disclosure in Action View'
        )
        described_class.call
      end

      it 'return count errors' do
        expect(described_class.call.count).to eq(3)
      end
    end
  end
end
