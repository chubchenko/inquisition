require 'axlsx'

require_relative 'file'
require_relative 'table'
require_relative 'collector'
require_relative 'row'
require_relative 'header'
require_relative 'gem'
require_relative 'version'

module Inquisition
  module Outputter
    class Xlsx
      class Builder
        DEFAULT_SHEET_NAME = 'GEMFILE'.freeze

        def self.call(collection)
          new(collection).call
        end

        def initialize(collection, file = File.new)
          @collection = collection
          @file = file

          @package = ::Axlsx::Package.new
          @table = Table.new
        end

        def call
          @package.tap do |package|
            sheet = package.workbook.add_worksheet(name: DEFAULT_SHEET_NAME)

            @table.each do |row|
              sheet.add_row(row.to_a)
            end
          end.serialize(file.path)
        end

        private

        attr_reader :file
      end
    end
  end
end
