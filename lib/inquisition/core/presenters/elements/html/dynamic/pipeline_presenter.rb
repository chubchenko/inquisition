module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Dynamic
            class PipelinePresenter < Core::Presenters::DynamicPresenter
              ELEMENT_STRUCTURE = {
                total: '',
                issues: []
              }.freeze

              def add_items(array_of_issues)
                element[:issues] = array_of_issues
                add_total
              end

              def add_total
                element[:total] = element[:issues].reject(&:empty?).count
              end

              def element
                @element ||= ELEMENT_STRUCTURE.dup
              end
            end
          end
        end
      end
    end
  end
end
