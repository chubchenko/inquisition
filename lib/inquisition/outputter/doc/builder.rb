require_relative 'file'

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

          ::File.open(@file.path, 'wb')
        end
      end
    end
  end
end
