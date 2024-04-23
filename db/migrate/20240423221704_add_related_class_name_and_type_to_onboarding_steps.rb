class AddRelatedClassNameAndTypeToOnboardingSteps < ActiveRecord::Migration[7.0]
  def change
    add_column :onboarding_steps, :related_class_name, :string
    add_column :onboarding_steps, :related_class_type, :string
  end
end
