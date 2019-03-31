module Inquisition
  module Core
    module Presenters
      module Data
        module Common
          class GitExistencePresenter < Presenters::StaticPresenter
            GIT_FOLDER = '.git'.freeze

            private

            def build_presenter
              @build_presenter ||= File.exist?(File.join(Dir.pwd, GIT_FOLDER))
            end
          end
        end
      end
    end
  end
end
