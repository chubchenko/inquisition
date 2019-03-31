module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Static
            module Pipeline
              class HottestIssuesPipelinePresenter < Core::Presenters::StaticPresenter
                private

                def build_presenter
                  @build_presenter ||= build_pipeline
                end

                def build_pipeline
                  add_items
                  element_presenter.element
                end

                def add_items
                  element_presenter.add_items(data)
                end

                def element_presenter
                  @element_presenter ||= Dynamic::PipelinePresenter.new
                end

                def data
                  @data ||= Data::Issues::HottestIssuesPresenter.instance.call
                end
              end
            end
          end
        end
      end
    end
  end
end
