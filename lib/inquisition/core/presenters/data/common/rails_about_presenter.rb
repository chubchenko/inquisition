module Inquisition
  module Core
    module Presenters
      module Data
        module Common
          class RailsAboutPresenter < Presenters::StaticPresenter
            COMMAND = 'rake about'.freeze

            private

            def build_presenter
              @build_presenter ||= prepared_data
            end

            def prepared_data
              @prepared_data ||= Hash[*parsed_data]
            end

            def parsed_data
              raw_data.split("\n").map(&method(:split_data)).flatten.reject(&:empty?).tap(&:shift)
            end

            def split_data(info)
              info.split('  ')
            end

            def raw_data
              @raw_data ||= run_cli(COMMAND)
            end
          end
        end
      end
    end
  end
end
