Rails.application.routes.draw do
  resources :emergencies
  resources :responders, format: 'json', param: :name
end
