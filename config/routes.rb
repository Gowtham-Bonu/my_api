Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace "api" do
    namespace "v1" do
      get "search/:title", to: "articles#search"
      get "search_comments/:comment", to: "comments#search"
      resources :articles do
        get '/page/:page', action: :index, on: :collection
        resources :comments do
          get '/page/:page', action: :index, on: :collection
        end
      end
    end
  end
end
