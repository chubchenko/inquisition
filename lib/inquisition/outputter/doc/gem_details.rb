require 'gems'

module Inquisition
  module Outputter
    class Doc
      class GemDetails
        attr_reader :name, :description, :link

        def initialize(name, description = '')
          @name = name
          @description = description
          @link = Gems.info('rails')['source_code_uri']
        end
      end
    end
  end
end
