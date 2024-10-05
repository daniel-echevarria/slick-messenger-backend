Rails.application.routes.draw do
  namespace :auth do
    post 'google', to: 'auth#google'
  end

  devise_for :users, path: '',
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
    # omniauth_callbacks: 'users/omniauth_callbacks'
  }
end
