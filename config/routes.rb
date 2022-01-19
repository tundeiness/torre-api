Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :persons, only: :show, param: :username
    end
  end

  # get ':persons', to: 'persons#show', as: :person
end
