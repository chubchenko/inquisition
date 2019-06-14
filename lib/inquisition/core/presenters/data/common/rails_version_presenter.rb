require 'rails'

module Inquisition
  module Core
    module Presenters
      module Data
        module Common
          class RailsVersionPresenter < Presenters::StaticPresenter
            private

            def build_presenter
              @build_presenter ||= Rails::VERSION::STRING
            end
          end
        end
      end
    end
  end
end
