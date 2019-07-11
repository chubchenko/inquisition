module Inquisition
  module Core
    module Checkers
      class GemChecker < Inquisition::Core::Checker
        private

        def check
          name = @args[:name]
          raise Error::NoGemError, name unless Gem.loaded_specs.key?(name)
        end
      end
    end
  end
end
