RSpec.describe Inquisition::Core::BaseBuilder, type: :unit do
  include AuditorsHelpModule

  subject { Inquisition::Core::BaseBuilder.new }

  describe '.call' do
    it 'raise NotImplementedError' do
      expect { subject.call }.to raise_error(NotImplementedError)
    end
  end
end
