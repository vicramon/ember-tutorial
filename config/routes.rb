Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root to: 'home#index'

  get 'chapters', to: 'home#chapters'
  get 'chapters/all', to: 'home#all'
  get 'about', to: 'home#about'
  get 'contact', to: 'home#contact'

  resources :contacts, only: [:index, :create]
  get '*path', to: 'chapters#show', as: 'chapter'
end
