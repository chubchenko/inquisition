require 'caxlsx'

require_relative 'file'
require_relative 'gem_set'

module Inquisition
  module Outputter
    class Xlsx
      class Builder
        WORKSHEET_NAME = 'Gems info'.freeze

        def self.call(collection)
          new(collection).call
        end

        def initialize(_collection, file = File.new)
          @file = file
          @package = Axlsx::Package.new
          @presenter = Xlsx::GemsInfo.new.call
        end

        def call
          fill_info
          save_worksheet
        end

        private

        attr_reader :package, :presenter, :file

        def fill_info
          presenter.each { |info| worksheet.add_row(info.values) }
        end

        def save_worksheet
          package.serialize(file.path)
        end

        def worksheet
          @worksheet ||= package.workbook.add_worksheet(name: WORKSHEET_NAME)
        end
      end
    end
  end
end
