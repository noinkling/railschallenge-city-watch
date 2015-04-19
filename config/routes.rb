Rails.application.routes.draw do
  defaults format: 'json' do
    resources :emergencies, param: :code, except: [:new, :edit, :destroy]
    resources :responders, param: :name, except: [:new, :edit, :destroy]
    match '*path' => 'application#render_404', via: :all
  end
end
