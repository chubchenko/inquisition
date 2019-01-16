module Inquisition
  module Core
    module Checkers
      class ExistFileChecker < Inquisition::Core::Checker
        private

        def check
          raise Errors::NoConfigFileError, @args[:file] unless file_exist?
        end

        def file_exist?
          File.exist?(File.join(destination, @args[:file]))
        end
      end
    end
  end
end
