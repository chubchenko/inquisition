module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Dynamic
            class PercirclePresenter < Core::Presenters::DynamicPresenter
              attr_reader :total, :number

              ELEMENT_STRUCTURE = {
                total: 0,
                number: 0,
                percent: 0
              }.freeze

              def initialize(total:, number:)
                @total = total
                @number = number
                build_element
              end

              def build_element
                element[:total] = total
                element[:number] = number
                element[:percent] = percent
              end

              def percent
                return 0 if total.zero?

                100 * number / total
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
