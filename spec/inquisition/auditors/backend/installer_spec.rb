RSpec.describe Inquisition::Auditors::Backend::Installer do
  describe '#call' do
    subject { Inquisition::Auditors::Backend::Installer.call }

    it_behaves_like 'call callable objects', Inquisition::Auditors::Backend::Installer => 'backend installer'
  end
end
