module Inquisition
  module Executor
    SUCCESS = 0
    FAILURE = 1

    Version = Class.new do
      def call(output = Configuration.instance.output)
        output.puts(Inquisition::Version.to_s)

        SUCCESS
      end
    end

    Help = Struct.new(:options) do
      def call(output = Configuration.instance.output)
        output.puts(options)

        SUCCESS
      end
    end

    Initialize = Class.new do
      def initialize(destination: Rails.root, output: Configuration.instance.output)
        @destination = destination
        @output = output
      end

      def call
        if File.exist?(path)
          output.puts("#{Configuration::DOTFILE} already exists at #{path}")

          FAILURE
        else
          copy

          output.puts("Writing new #{Configuration::DOTFILE} to #{path}")

          SUCCESS
        end
      end

      private

      attr_reader :destination, :output

      def path
        @path ||= begin
          Pathname.new(
            File.join(destination, Configuration::DOTFILE)
          )
        end
      end

      def copy
        File.open(path, 'w') do |file|
          file.write(Runner.collection.each.with_object(plugins: {}) do |runner, memo|
            memo[:plugins][runner.badge.to_s.to_sym] = { enabled: true }
          end.to_yaml)
        end
      end
    end
  end
end
