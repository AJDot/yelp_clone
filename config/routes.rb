Rails.application.routes.draw do
  root to: 'ui#index'
  namespace :ui do
    Dir.glob('app/views/ui/*.html.haml').sort.each do |file|
      wireframe = File.basename(file, '.html.haml')
      get wireframe unless wireframe == 'index' || wireframe.match(/^_/)
    end
  end
  resources :businesses, only: [:index, :show]
end
