Rails.application.routes.draw do
  resources :lectures do
    collection do 
      post 'file'
    end 
  end 
  resources :events do
    member  do 
      get 'organization'
    end 
  end 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
