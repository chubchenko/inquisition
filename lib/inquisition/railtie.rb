module Inquisition
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load File.join(File.dirname(__FILE__), 'tasks/inquisition.rake')
      load File.join(File.dirname(__FILE__), 'tasks/assets_compilation.rake')
    end
  end
end
