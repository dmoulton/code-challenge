Rails.application.routes.draw do
  get 'content/index'
  get 'content', to: "content#index"
  post 'content/save'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "content#index"
end
