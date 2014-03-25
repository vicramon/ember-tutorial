EmberTutorial::Application.routes.draw do
  get 'chapters', to: 'home#chapters'
  get 'about', to: 'home#about'
  get 'contact', to: 'home#contact'
  root to: 'home#index'
  get '*path', to: 'chapters#show', as: 'chapter'
end
