module Inquisition
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load File.join(File.dirname(__FILE__), 'tasks/inquisition.rake')
    end
  end
end
