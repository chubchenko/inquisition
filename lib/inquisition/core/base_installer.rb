module Inquisition
  module Core
    class BaseInstaller
      class << self
        def call
          raise NotImplementedError
        end
      end
    end
  end
end
