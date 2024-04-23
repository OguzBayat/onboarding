class OnboardingStep < ApplicationRecord
  belongs_to :company
  default_scope { order(step_order: :asc) }

  validates :title, :description, :video_info, :step_order, presence: true
  validates :step_input, numericality: { only_integer: true }, allow_blank: true

  before_update :prevent_update_if_locked, :unless => :locked_changed?
  before_update :set_completed_at, :increase_completed_step_count, :if => :completed_changed?
  after_update :update_onboarding_status

  def related_ratio_to_be_unlocked
    self.related_ratio.to_sym
  end

  private

    def prevent_update_if_locked
      if self.locked?
        errors.add(:base, "Cannot update because the step is locked.")
        throw(:abort)
      end
    end

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
