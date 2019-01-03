module Inquisition
  module Core
    class Configer
      class << self
        def call(*)
          return output_already_exists if config_exists?

          copy_config_file
        end

        private

        def config_name
          raise NotImplementedError
        end

        def linter_name
          raise NotImplementedError
        end

        def target_directory
          Dir.pwd
        end

        def output_already_exists
          Outputer.config_already_exist(linter_name)
          Outputer.done
        end

        def config_exists?
          File.exist?(File.join(Dir.pwd, config_name))
        end

        def config_path
          File.join(File.dirname(__FILE__), '..', 'auditors', 'configs', config_name)
        end

        def copy_config_file
          FileUtils.cp config_path, target_directory, preserve: true, verbose: false
        end
      end
    end
  end
end
