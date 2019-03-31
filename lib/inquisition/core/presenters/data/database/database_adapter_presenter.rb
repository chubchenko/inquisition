module Inquisition
  module Core
    module Presenters
      module Data
        module Database
          class DatabaseAdapterPresenter < Presenters::StaticPresenter
            ADAPTER_KEY = 'Database adapter'.freeze

            private

            def build_presenter
              @build_presenter ||= Data::Common::RailsAboutPresenter.instance.call.dig(ADAPTER_KEY).to_s.capitalize
            end
          end
        end
      end
    end
  end
end
