require 'singleton'

module Inquisition
  class Configuration
    include Singleton

    def verbose?
      true
    end
  end
end
