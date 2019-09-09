module Inquisition
  module Bundler
    module Leak
      class Issue
        def initialize(advisory)
          @advisory = advisory
        end

        def to_h
          {
            severity: :low,
            # category: :performance,
            message: advisory.title,
            path: 'Gemfile.lock',
            line: nil
          }
        end

        private

        attr_reader :advisory
      end
    end
  end
end
