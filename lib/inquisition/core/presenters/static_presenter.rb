require 'singleton'

module Inquisition
  module Core
    module Presenters
      class StaticPresenter < BasePresenter
        include Singleton

        def call
          build_presenter
        end
      end
    end
  end
end
