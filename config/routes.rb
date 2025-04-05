Rails.application.routes.draw do
  root 'home#index'
  get 'about', to: 'about#index'
  get 'skills', to: 'skills#index'
  get 'guestbook', to: 'guestbook#index'
  get 'guestbook/:id', to: 'guestbook#show', as: 'guestbook_entry'
  post 'guestbook', to: 'guestbook#create'
  resources :projects, only: [:index, :show]
end
