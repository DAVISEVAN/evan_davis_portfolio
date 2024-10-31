Rails.application.routes.draw do
  root 'home#index'
  get 'about', to: 'about#index'
  get 'projects', to: 'projects#index'
  get 'skills', to: 'skills#index'
  get 'guestbook', to: 'guestbook#index'
  post 'guestbook', to: 'guestbook#create'
end
