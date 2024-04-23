class AddSyncCompletedMailSentAtToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :sync_completed_mail_sent_at, :datetime
  end
end
