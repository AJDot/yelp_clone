Rails.application.routes.draw do
  root to: 'ui#index'

  get 'register', to: 'users#new', as: 'register'

  resources :users, only: [:create]
  resources :businesses, only: [:index, :show]

  namespace :ui do
    Dir.glob('app/views/ui/*.html.haml').sort.each do |file|
      wireframe = File.basename(file, '.html.haml')
      get wireframe unless wireframe == 'index' || wireframe.match(/^_/)
    end
  end
end
