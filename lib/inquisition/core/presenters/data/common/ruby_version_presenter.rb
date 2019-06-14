module Inquisition
  module Core
    module Presenters
      module Data
        module Common
          class RubyVersionPresenter < Presenters::StaticPresenter
            private

            def build_presenter
              @build_presenter ||= RUBY_VERSION
            end
          end
        end
      end
    end
  end
end
