module Inquisition
  module Executor
    Version = Class.new do
      def call(output = Configuration.instance.output)
        output.puts(Inquisition::Version.to_s)

        0
      end
    end

    Help = Struct.new(:options) do
      def call(output = Configuration.instance.output)
        output.puts(options)

        0
      end
    end

    InitConfig = Class.new do
      def call(output = Configuration.instance.output)
        output.puts(Inquisition::InitConfig.result)

        0
      end
    end
  end
end
