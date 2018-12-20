module Inquisition
  class Railtie < Rails::Railtie
    if Rails.env.development? || Rails.env.test?
      require 'awesome_print'
      require 'benchmark/ips'
      require 'bullet'
      require 'hirb'
      require 'pry-byebug'
      require 'pry-rails'
      require 'pry-rescue'
      require 'pry-stack_explorer'
      require 'simplecov'
    end

    if Rails.env.development?
      rake_tasks do
        load 'inquisition/tasks/inquisition.rake'
      end
    end
  end
end
