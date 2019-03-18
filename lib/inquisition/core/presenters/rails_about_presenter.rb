module Inquisition
  module Core
    module Presenters
      class RailsAboutPresenter < BasePresenter
        INFO_DATABASE_ADAPTER = 'Database adapter'.freeze
        COMMAND = 'rake about'.freeze

        def database_adapter
          prepared_data[INFO_DATABASE_ADAPTER]
        end

        private

        def parsed_data
          raw_data.split("\n").map(&method(:split_data)).flatten.reject(&:blank?).tap(&:shift)
        end

        def split_data(info)
          info.split('  ')
        end

        def prepared_data
          @prepared_data ||= Hash[*parsed_data]
        end

        def raw_data
          @raw_data ||= run_cli(COMMAND)
        end
      end
    end
  end
end
