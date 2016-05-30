Rails.application.routes.draw do
  resources :posts, only: [:create, :index], defaults: { format: 'json' } do
    get :top_ip, on: :collection

    member do
      post :set_rate
    end
  end
end
