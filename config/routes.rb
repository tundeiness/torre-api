Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :persons, only: :show, param: :username
    end
  end


  #get 'persons/:id', to: 'persons#show'
  get ':persons', to: 'persons#show', as: :person
  # resources :persons
  
  #match 'persons/:id' => 'persons#show', :via => :get
  #match '/*username', to: redirect { |params| "/api/v1/#{params[:username]}" }
  # match '/username', to: redirect { |params| "/api/v1/#{params[:username]}" }, :via => [:get, :post]
end
