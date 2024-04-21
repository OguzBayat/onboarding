Rails.application.routes.draw do
  # API routes hould be in /api/v1
  namespace :api do
    namespace :v1 do
      get ':company_id/sync_progress_infos', to: 'sync_progress_infos#index'

      get ':company_id/onboarding_steps', to: 'onboarding_steps#index'
      get ':company_id/onboarding_steps/:id', to: 'onboarding_steps#show'
      put ':company_id/onboarding_steps/:id', to: 'onboarding_steps#update'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
