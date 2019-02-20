module Inquisition
  module Core
    module Configurers
      class CopyFileConfigure < Inquisition::Core::Configure
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
          FileUtils.mkdir_p destination
          FileUtils.cp config_path, destination, preserve: true, verbose: false
        end
      end
    end
  end
end
