require 'axlsx'

require_relative 'file'

module Inquisition
  module Outputter
    class Xlsx
      class Builder
        def self.call(collection)
          new(collection).call
        end

        def initialize(collection, file = File.new)
          @file = file
          @collection = collection
          @package = Axlsx::Package.new
        end

        def call
          ::FileUtils.mkdir_p(@file.path.dirname)

          package.serialize(@file.path)
        end

        private

        attr_reader :package
      end
    end
  end
end
