require 'fasterer/file_traverser'
require 'inquisition/fasterer/config'

module Inquisition
  module Fasterer
    class FileTraverser < ::Fasterer::FileTraverser
      def initialize(path)
        super
        @config = Config.new
      end

      def offenses_grouped_by_type(analyzer)
        analyzer.errors.group_by(&:offense_name).delete_if do |offense_name, _|
          ignored_speedups.include?(offense_name)
        end
      end
    end
  end
end
