module Inquisition
  module Outputter
    class Doc
      module TPL
        class Quality
          class Rubocop
            def self.call(issues)
              new(
                Security::Collector.new(issues, ::Inquisition::Rubocop::Runner).call
              )
            end

            EXTENSIONS = %w[rubocop-rspec rubocop-rails rubocop-performance rubocop-rake rubocop-md].freeze
            attr_reader :collection

            def initialize(collection)
              @collection = collection
            end

            def extensions
              EXTENSIONS.each do |gem|
                next if locked_gems.key?(gem)

                extension = TPL::Stack::Collector.new([gem]).call.first
                yield(extension&.name || gem, extension&.homepage)
              end
            end

            def produce
              binding
            end

            def autocorrect_issues
              collection.group_by(&:context).fetch(:corrected, [])
            end

            def inspect_files
              collection&.first&.runner&.modified_runner&.target_files || []
            end

            def contains_rubocop
              locked_gems.key?('rubocop') ? 'present' : 'absent'
            end

            def link
              @link ||= Stack::Collector.new(['rubocop']).call.first.homepage
            end

            private

            def locked_gems
              @locked_gems ||= ::Bundler.locked_gems.dependencies
            end
          end
        end
      end
    end
  end
end
