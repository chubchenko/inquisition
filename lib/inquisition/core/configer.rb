module Inquisition
  module Core
    class Configer
      class << self
        def call
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
          puts "Config for #{linter_name} already exists"
        end

        def config_exists?
          File.exists?(config_path)
        end

        def config_path
          File.join(File.dirname(__FILE__), 'config', config_name)
        end

        def copy_config_file
          FileUtils.cp config_path, target_directory, preserve: true, verbose: false
        end
      end
    end
  end
end
