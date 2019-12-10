require_relative 'file'
require_relative '../html/template'
require_relative 'view_helper'

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
          ::FileUtils.mkdir_p(@file.path.dirname)

          documentation = HTML::Template.new('documentation_word').render(ViewHelper.new)
          ::File.open(@file.path, 'w') { |file| file.write(documentation) }
        end
      end
    end
  end
end
