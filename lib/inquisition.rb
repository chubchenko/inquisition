# frozen_string_literal: true

require 'inquisition/config/initializer'
Zeitwerk::Loader.for_gem.setup

module Inquisition
  def self.root
    Gem::Specification.find_by_name('inquisition').gem_dir
  end
end
