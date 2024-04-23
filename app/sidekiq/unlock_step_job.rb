class UnlockStepJob
  include Sidekiq::Job

  def perform(step_id)
    onboarding_step = OnboardingStep.find(step_id)
    company = Company.find(onboarding_step.company_id)

    progress_info = ProgressInfoService.call(company)

    if progress_info[onboarding_step.related_ratio.to_sym] == 1
      onboarding_step.update(locked: false)
    end
  end
end
