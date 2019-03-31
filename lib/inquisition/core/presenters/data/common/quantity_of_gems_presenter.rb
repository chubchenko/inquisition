module Inquisition
  module Core
    module Presenters
      module Data
        module Common
          class QuantityOfGemsPresenter < Presenters::StaticPresenter
            GEMFILE = 'Gemfile'.freeze

            private

            def build_presenter
              @build_presenter ||= File.foreach(File.join(Dir.pwd, GEMFILE)).grep(/gem /).count
            end
          end
        end
      end
    end
  end
end
