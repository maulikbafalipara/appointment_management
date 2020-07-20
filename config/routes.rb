require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => '/sidekiq'

  devise_for :doctors,
                controllers: {
                registrations: 'doctors/registrations'
              }

  devise_for :patients,
                controllers: {
                registrations: 'patients/registrations'
              }

  resources :doctors do
    collection do
      post 'reject/:appointment_id', to: 'doctors#reject', as: :reject_appointment
      post 'confirm/:appointment_id', to: 'doctors#confirm', as: :confirm_appointment
    end
  end

  resources :patients do
    resources :appointments, only: [:new, :create] do
      get :cancel, on: :member
    end
    get :doctors, on: :collection
  end

  # get ':id/confirm', to: 'appointments#confirm_appointment', as: :confirm_appointment

  root to: 'home#landing'
end
