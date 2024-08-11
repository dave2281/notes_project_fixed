Rails.application.routes.draw do
  resources :notes, only: [:index, :new, :create, :edit, :update, :destroy] do
    get 'delete', to: 'notes#destroy'
  end

  get 'pages/show_by_tag/:tag', to: 'pages#show_by_tag', as: 'show_by_tag'
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: 'pages#home', as: :authenticated_root
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end

    get 'users/sign_out' => "devise/sessions#destroy"
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
