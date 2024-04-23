class SendSyncCompletedEmailJob
  include Sidekiq::Job

  def perform(company_id)
    company = Company.find(company_id)

    progress_info = ProgressInfoService.call(company)

    if progress_info[:total_progress_ratio] == 1
      SyncCompletedMailer.sync_completed_email(company.user, progress_info).deliver_later
      company.update(sync_completed_mail_sent_at: DateTime.now)
    end
  end
end
