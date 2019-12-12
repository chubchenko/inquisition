module Inquisition
  module Outputter
    class Doc
      class Template
        def initialize(filename)
          @filename = filename
        end

        def render(context)
          ::ERB.new(::File.read(path)).result(context.produce)
        end

        private

        attr_reader :filename

        def path
          ::File.join(
            Inquisition.root, 'views', 'doc', "#{filename}.rhtml"
          )
        end
      end
    end
  end
end
