RSpec.describe Inquisition::Core::Checkers::RubyVersionChecker, type: :unit do
  subject { Inquisition::Core::Checkers::RubyVersionChecker.new(**args) }
  let(:args) { { from_version: '1.9', to_version: '2.1' } }

  describe '.call' do
    context 'when ruby version not between passes values' do
      before { stub_const('RUBY_VERSION', '1.8') }

      it 'raise InvalidRubyVersionError' do
        expect{ subject.call }.to raise_error(Inquisition::Error::InvalidRubyVersionError)
      end
    end

    context 'when ruby version greater than passes values' do
      before { stub_const('RUBY_VERSION', '2.5') }

      it 'raise InvalidRubyVersionError' do
        expect{ subject.call }.to raise_error(Inquisition::Error::InvalidRubyVersionError)
      end
    end

    context 'when ruby version between passes values' do
      before { stub_const('RUBY_VERSION', '2.0') }

      context 'when passes not interval' do
        let(:args) { { from_version: '1.9' } }

        it 'not raise any errors' do
          expect{ subject.call }.not_to raise_error
        end
      end

      context 'when passes interval' do
        it 'not raise any errors' do
          expect{ subject.call }.not_to raise_error
        end
      end
    end
  end
end
