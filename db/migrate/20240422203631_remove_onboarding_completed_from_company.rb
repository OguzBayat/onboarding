class RemoveOnboardingCompletedFromCompany < ActiveRecord::Migration[7.0]
  def change
    remove_column :companies, :onboarding_completed, :boolean
  end
end
