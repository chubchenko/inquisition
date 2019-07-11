module Inquisition
  module Core
    module Checkers
      class RubyVersionChecker < Inquisition::Core::Checker
        private

        def check
          raise Error::InvalidRubyVersionError, @args[:from_version] unless valid?
        end

        def valid?
          @args[:to_version] ? between : greater_than
        end

        def greater_than
          RUBY_VERSION >= @args[:from_version]
        end

        def between
          greater_than && RUBY_VERSION <= @args[:to_version]
        end
      end
    end
  end
end
