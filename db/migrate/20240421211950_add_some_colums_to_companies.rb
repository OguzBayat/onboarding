class AddSomeColumsToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :status, :string
    add_column :companies, :step_count, :integer
    add_column :companies, :completed_step_count, :integer
  end
end
