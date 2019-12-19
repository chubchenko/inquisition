module Inquisition
  module Outputter
    class Doc
      class GemDetails
        attr_reader :name, :description, :link

        DEFAULT_GEM_LINK = 'https://rubygems.org/'.freeze

        def initialize(name, description = '')
          @name = name
          @description = description
          @link = gem_link
        end

        def to_h
          { name: name, link: link }
        end

        def gem_exists?(gem)
          Gem.loaded_specs.key?(gem)
        end

        private

        def gem_link
          gem_exists?(name) ? Gem::Specification.find_by_name(name).homepage : DEFAULT_GEM_LINK
        end
      end
    end
  end
end
