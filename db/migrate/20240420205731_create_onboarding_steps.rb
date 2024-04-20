class CreateOnboardingSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :onboarding_steps do |t|
      t.string :title
      t.text :description
      t.string :video_info
      t.datetime :completed_at
      t.integer :step_order
      t.boolean :locked
      t.integer :step_input
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
