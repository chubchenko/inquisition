module Inquisition
  module Core
    module Configers
      class UpdateFileConfiger < Inquisition::Core::Configer
        private

        def setup
          Core::Checkers::ExistFileChecker.call(@args[:file])
          append_to_config_file unless already_contains?
        end

        def append_to_config_file
          File.open(config_file, 'a') do |file|
            file.puts(*file_lines(template_file))
          end
        end

        def already_contains?
          file_lines(config_file).grep(/#{check_data}/).any?
        end

        def check_data
          file_lines(template_file).first.scan(/\w+/).first
        end

        def file_lines(file)
          File.readlines(file)
        end

        def template_file
          @template_file ||= File.join(@args[:template_path], 'config', File.basename(@args[:file]))
        end

        def config_file
          @config_file ||= File.join(target_directory, @args[:file])
        end
      end
    end
  end
end
