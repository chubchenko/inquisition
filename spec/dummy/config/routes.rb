Rails.application.routes.draw do
  namespace :rails do
    get 'properties', action: :properties, controller: 'info'
    get 'index', action: :index, controller: 'info'
    get 'routes', action: :routes, controller: 'info'
    get 'index', action: :index, controller: 'mailers'
    get 'preview', action: :preview, controller: 'mailers'
    get 'welcome', action: :index, controller: 'welcome'
  end
end
