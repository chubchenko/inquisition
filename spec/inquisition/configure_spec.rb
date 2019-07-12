RSpec.describe Inquisition::Configure, type: :unit do
  describe '#call' do
    subject { Inquisition::Configure.call }

    context 'when authenticate configure' do
      before do
        allow(Inquisition::BaseConfig.instance).to receive(:config_exist?).and_return(true)
        allow(Inquisition::BaseConfig.instance).to receive(:auditor_enabled?).and_return(false)
      end

      context 'when backend configurers are enabled' do
        before do
          allow(Inquisition::BaseConfig.instance).to receive(:auditor_enabled?).with(:backend).and_return(true)
        end

        it_behaves_like 'call callable objects', Inquisition::Auditors::Backend::Installer => 'backend configure'
      end

      context 'when common configurers are enabled' do
        before do
          allow(Inquisition::BaseConfig.instance).to receive(:auditor_enabled?).with(:common).and_return(true)
        end

        it_behaves_like 'call callable objects', Inquisition::Auditors::Common::Installer => 'common configure'
      end
    end

    context 'when configure was not authenticate' do
      before do
        allow(Inquisition::BaseConfig.instance).to receive(:config_exist?).and_return(false)
      end

      it 'raise authenticate error' do
        expect{ subject.call }.to raise_error(Inquisition::Error::BaseConfigAbsenseError)
      end
    end
  end
end
