Rails.application.routes.draw do
  root to: 'businesses#index'

  get 'register', to: 'users#new', as: 'register'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:show, :create]
  resources :businesses, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create]
  end

  resources :ui, only: [:index] do
    collection do
      Dir.glob('app/views/ui/*.html.haml').sort.each do |file|
        wireframe = File.basename(file, '.html.haml')
        get wireframe unless wireframe == 'index' || wireframe.match(/^_/)
      end
    end
  end
end
