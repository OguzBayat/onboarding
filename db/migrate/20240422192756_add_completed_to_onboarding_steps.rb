class AddCompletedToOnboardingSteps < ActiveRecord::Migration[7.0]
  def change
    add_column :onboarding_steps, :completed, :boolean, default: false
  end
end
