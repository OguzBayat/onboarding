namespace :check_progress do
  desc "Unlocks steps that have completed their related progress."
  task unlock_steps: :environment do
    locked_steps = OnboardingStep.where.not(related_ratio: nil).where(locked: true)

    locked_steps.each do |step|
      UnlockStepJob.perform_async(step.id)
    end
  end

end
