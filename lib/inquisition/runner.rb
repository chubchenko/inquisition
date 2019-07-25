module Inquisition
  class Runner
    def self.collection
      @collection ||= []
    end

    def self.inherited(descendant)
      collection.push(descendant)
    end

    def self.call
      new.()
    end

    def self.self_key
      (name.split('::') - %w[Inquisition Runner]).join('_').downcase
    end
  end
end
