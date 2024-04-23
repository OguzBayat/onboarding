class SyncCompletedMailer < ApplicationMailer
  def sync_completed_email(user, progress_info)
    @user = user
    @progress_info = progress_info
    mail(to: @user.email, subject: 'Your Shopify data was synced')
  end
end
