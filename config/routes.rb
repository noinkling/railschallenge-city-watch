Rails.application.routes.draw do
  resources :responders, format: 'json', param: :name
end
