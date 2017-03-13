Rails.application.routes.draw do
  resources :users
  resources :articles do
    get :history
  end
end
