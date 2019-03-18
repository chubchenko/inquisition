require 'rake'
require 'rails/code_statistics'

module Inquisition
  module Core
    module Presenters
      class FilesSummaryPresenter < BasePresenter
        STATS_DIRECTORIES = [
          %w[Controllers app/controllers],
          %w[Helpers app/helpers],
          %w[Jobs app/jobs],
          %w[Models app/models],
          %w[Mailers app/mailers],
          %w[Mailboxes app/mailboxes],
          %w[Channels app/channels],
          %w[JavaScripts app/assets/javascripts],
          %w[JavaScript app/javascript],
          %w[Libraries lib/],
          %w[APIs app/apis],
          %w[Controller\ tests test/controllers],
          %w[Helper\ tests test/helpers],
          %w[Model\ tests test/models],
          %w[Mailer\ tests test/mailers],
          %w[Mailbox\ tests test/mailboxes],
          %w[Channel\ tests test/channels],
          %w[Job\ tests test/jobs],
          %w[Integration\ tests test/integration],
          %w[System\ tests test/system]
        ].freeze

        private

        def build_presenter
          CodeStatistics.new(*directories).instance_variable_get(:@statistics).map(&method(:build_presenter_hash))
        end

        def build_presenter_hash(type, statistics)
          {
            type: type,
            statistics: build_statisctics(statistics)
          }
        end

        def build_statisctics(statistics)
          {
            classes: statistics.classes,
            code_lines: statistics.code_lines,
            lines: statistics.lines,
            methods: statistics.methods
          }
        end

        def directories
          collected_directories.select { |_name, dir| File.directory?(dir) }
        end

        def collected_directories
          STATS_DIRECTORIES.collect do |name, dir|
            [name, "#{File.dirname(Rake.application.rakefile_location)}/#{dir}"]
          end
        end
      end
    end
  end
end
