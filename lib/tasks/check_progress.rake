namespace :check_progress do
  desc "Unlocks steps that have completed their related progress."
  task unlock_steps: :environment do
    locked_steps = OnboardingStep.where.not(related_ratio: nil).where(locked: true)

    locked_steps.each do |step|
      UnlockStepJob.perform_async(step.id)
    end
  end

  task send_sync_completed_mail: :environment do
    companies = Company.where(sync_completed_mail_sent_at: nil)

    companies.each do |company|
      SendSyncCompletedEmailJob.perform_async(company.id)
    end
  end
end
