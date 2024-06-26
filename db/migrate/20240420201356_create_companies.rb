class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :title
      t.boolean :onboarding_completed
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
