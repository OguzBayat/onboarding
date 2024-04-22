class OnboardingStep < ApplicationRecord
  belongs_to :company
  default_scope { order(step_order: :asc) }

  validates :title, :description, :video_info, :step_order, presence: true

  before_update :set_completed_at, :increase_completed_step_count, :if => :completed_changed?
  after_update :update_onboarding_status

  private

    def set_completed_at
      self.completed_at = DateTime.now
    end

    def increase_completed_step_count
      self.company.update(completed_step_count: (self.company.completed_step_count + 1))
    end

    def update_onboarding_status
      status = if self.company.step_count == self.company.completed_step_count
                'completed'
               else
                'in_progress'
               end

      self.company.update!(status: status)
    end
end
