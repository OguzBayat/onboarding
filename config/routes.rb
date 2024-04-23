Rails.application.routes.draw do
  # API routes hould be in /api/v1
  namespace :api do
    namespace :v1 do
      scope ':company_id' do
        get 'iam', to: 'base_api#me'

        get 'sync_progress_infos', to: 'sync_progress_infos#index'\

        resources :onboarding_steps, only: [:index, :show, :update]
      end

    end
  end
end
