require 'execjs'

module Inquisition
  module Core
    module Presenters
      module Data
        module Common
          class JavascriptRuntimeVersionPresenter < Presenters::StaticPresenter
            private

            def build_presenter
              @build_presenter ||= ExecJS.runtime.name
            end
          end
        end
      end
    end
  end
end
