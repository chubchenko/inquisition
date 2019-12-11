module Inquisition
  module Outputter
    class Xlsx
      class GemDetailedInfo
        autoload :Vulnerability, 'inquisition/outputter/xlsx/detailed_info/vulnerability'

        def initialize(gem_info)
          @gem_info = gem_info
        end

        def call
          {
            detailed_status: '',
            color: ''
          }
        end

        private

        attr_reader :gem_info
      end
    end
  end
end
