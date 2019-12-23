module Inquisition
  module Outputter
    class Xlsx
      class Header < Row
        def to_a
          [
            'Name',
            'Source Code URI',
            'Current Version',
            'Newest Version',
            'Outdated',
            'Environment',
            'Status'
          ]
        end
      end
    end
  end
end
