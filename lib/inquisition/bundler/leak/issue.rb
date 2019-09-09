module Inquisition
  module Bundler
    module Leak
      class Issue
        def initialize(leaked_gem, advisory)
          @leaked_gem = leaked_gem
          @advisory = advisory
        end

        def to_h
          {
            severity: :low,
            # category: :performance,
            message: "#{leaked_gem.name} #{leaked_gem.version} - #{advisory.title}",
            path: 'Gemfile.lock',
            line: nil
          }
        end

        private

        attr_reader :leaked_gem, :advisory
      end
    end
  end
end
