module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Static
            module Table
              class FilesSummaryTablePresenter < Core::Presenters::StaticPresenter
                TABLE_HEADERS = %w[Name Linses LOC Classes Methods].freeze

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
                  element_presenter.add_body_items(table_body)
                end

                def table_body
                  data.map(&method(:prepare_body))
                end

                def prepare_body(item)
                  statistics = item[:statistics]
                  {
                    type: item[:type],
                    lines: statistics[:lines],
                    code_lines: statistics[:code_lines],
                    classes: statistics[:classes],
                    methods: statistics[:methods]
                  }
                end

                def element_presenter
                  @element_presenter ||= Dynamic::TablePresenter.new
                end

                def data
                  @data ||= Data::Common::FilesSummaryPresenter.instance.call
                end
              end
            end
          end
        end
      end
    end
  end
end
