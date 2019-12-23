require_relative 'file'
require_relative 'template'
require_relative 'tpl/layout'

module Inquisition
  module Outputter
    class Doc
      class Builder
        def self.call(collection)
          new(collection).call
        end

        def initialize(collection, file = File.new)
          @collection = collection
          @file = file
        end

        def call
          ::File.open(@file.path, 'wb') do |file|
            file.puts(Template.new('layout').render(TPL::Layout.new))
          end
        end
      end
    end
  end
end
