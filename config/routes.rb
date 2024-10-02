Rails.application.routes.draw do
  devise_for :users, path: '',
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
