Rails.application.routes.draw do
  resources :sad_cats, only: [:index, :new, :create]

  get 'list_cats', to: 'sad_cats#list_cats'
  root 'sad_cats#index'
end
