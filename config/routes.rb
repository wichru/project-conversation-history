Rails.application.routes.draw do
  root 'projects#show'

  resources :projects, only: %i[show] do
    resources :comments, only: %i[create]
  end
end
