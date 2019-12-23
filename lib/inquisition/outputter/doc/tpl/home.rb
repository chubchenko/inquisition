require 'date'

module Inquisition
  module Outputter
    class Doc
      module TPL
        class Home < Base
          def initialize
            @today = ::Date.today
          end

          def name
            @name ||= ::Rails.application.class.parent_name.underscore.upcase
          end

          def date
            @date ||= begin
              [
                today.day.ordinalize,
                ::Date::MONTHNAMES[today.month],
                today.year
              ].join(' ')
            end
          end

          private

          attr_reader :today
        end
      end
    end
  end
end
