require_relative '../../dummy/config/environment'

RSpec.describe Inquisition::Bundler::Audit::Runner do
  describe '#call' do
    before { allow(Dir).to receive(:pwd).and_return(File.join(Dir.pwd, 'spec/dummy')) }

    context 'when check errors with bundler-audit scanner' do
      it 'scanner.scan return errors' do
        expect(Inquisition::Issue).to receive(:new).with(
          level: "low",
          line: '',
          runner: be_kind_of(described_class),
          file: "/home/rostik/.local/share/ruby-advisory-db/gems/actionview/CVE-2019-5418.yml",
          message: 'File Content Disclosure in Action View'
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: "low",
          line: '',
          runner: be_kind_of(described_class),
          file: "/home/rostik/.local/share/ruby-advisory-db/gems/actionview/CVE-2019-5419.yml",
          message: 'Denial of Service Vulnerability in Action View'
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: "low",
          line: '',
          runner: be_kind_of(described_class),
          file: "/home/rostik/.local/share/ruby-advisory-db/gems/railties/CVE-2019-5420.yml",
          message: 'Possible Remote Code Execution Exploit in Rails Development Mode'
        )
        described_class.call
      end

      it 'return count errors' do
        expect(described_class.call.count).to eq(3)
      end
    end
  end
end
