class Inquisition::Railtie < Rails::Railtie
  if Rails.env.development? || Rails.env.test?
    require 'awesome_print'
    require 'benchmark/ips'
    require 'bullet'
    require 'colorize'
    require 'hirb'
    require 'pry-byebug'
    require 'pry-rails'
    require 'pry-rescue'
    require 'pry-stack_explorer'
    require 'simplecov'
  end

  if Rails.env.development?
    rake_tasks do
      load 'tasks/inquisition.rake'
    end
  end
end
