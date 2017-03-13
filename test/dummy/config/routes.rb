Rails.application.routes.draw do
  resources :articles do
    get :history
  end
end
