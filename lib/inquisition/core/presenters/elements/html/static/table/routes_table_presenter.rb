module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Static
            module Table
              class RoutesTablePresenter < Core::Presenters::StaticPresenter
                TABLE_HEADERS = %w[Prefix Verb URI Pattern].freeze

                private

                def build_presenter
                  @build_presenter ||= build_table
                end

                def build_table
                  add_headers
                  add_body
                  element_presenter.element
                end

                def add_headers
                  element_presenter.add_headers(TABLE_HEADERS)
                end

                def add_body
                  element_presenter.add_body_items(data)
                end

                def element_presenter
                  @element_presenter ||= Dynamic::TablePresenter.new
                end

                def data
                  @data ||= Data::Common::RoutesPresenter.instance.call
                end
              end
            end
          end
        end
      end
    end
  end
end
