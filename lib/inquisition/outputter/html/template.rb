module Inquisition
  module Outputter
    class HTML
      class Template
        def initialize(filename)
          @filename = filename
        end

        def render(context)
          ERB.new(File.read(path)).result(context.produce)
        end

        private

        def path
          File.join(
            Inquisition.root, 'views', "#{@filename}.rhtml"
          )
        end
      end
    end
  end
end
