Rails.application.routes.draw do

  resources :products

  resources :users
  root to: 'users#index'

  # mount InstantUpload::Engine => "/instant_upload"
end
