class AddRelatedRatioToOnboardingSteps < ActiveRecord::Migration[7.0]
  def change
    add_column :onboarding_steps, :related_ratio, :string
  end
end
