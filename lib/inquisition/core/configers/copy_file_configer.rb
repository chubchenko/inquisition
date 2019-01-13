module Inquisition
  module Core
    module Configers
      class CopyFileConfiger < Inquisition::Core::Configer
        private

        def setup
          copy_config_file unless config_file_exist?
        end

        def config_file_exist?
          File.exist?(File.join(destination, @args[:file]))
        end

        def config_path
          File.join(__dir__, '..', '..', 'auditors', 'configs', @args[:file])
        end

        def copy_config_file
          FileUtils.cp config_path, destination, preserve: true, verbose: false
        end
      end
    end
  end
end
