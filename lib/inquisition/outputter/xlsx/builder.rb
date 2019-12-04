require 'axlsx'

module Inquisition
  module Outputter
    class XLSX
      class Builder
        attr_reader :package

        def self.call(collection)
          new(collection).call
        end

        def initialize(collection)
          @collection = collection
          @package = Axlsx::Package.new
        end

        def call
          package.serialize(path)
        end

        private

        def path
          File.join(
            Inquisition::Configuration.instance.output_path, filename + '.xlsx'
          )
        end

        def filename
          [Rails.application.class.parent.name.underscore, Time.current.strftime('%d_%m_%y')].join('_')
        end
      end
    end
  end
end
