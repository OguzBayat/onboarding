class OnboardingStep < ApplicationRecord
  belongs_to :company
  default_scope { order(step_order: :asc) }

  validates :title, :description, :video_info, :step_order, presence: true
  validates :step_input, numericality: { only_integer: true }, allow_blank: true

  before_update :prevent_update_if_locked, :unless => :locked_changed?
  before_update :prevent_update_if_previous_step_does_not_completed, :unless => :skipped_changed?
  before_update :set_completed_at, :increase_completed_step_count, :if => :completed_changed?
  after_update :update_onboarding_status
  after_update :run_side_effects, if: Proc.new { has_side_effect? }

  def has_side_effect?
    related_class_name.present? && related_class_type.present?
  end

  private

    def prevent_update_if_previous_step_does_not_completed
      if (step_order - company.completed_step_count) > 1
        errors.add(:base, "Cannot update because the previous steps did not complete.")
        throw(:abort)
      end
    end

    def prevent_update_if_locked
      if locked?
        errors.add(:base, "Cannot update because the step is locked.")
        throw(:abort)
      end
    end

    def set_completed_at
      self.completed_at = DateTime.now
    end

    def increase_completed_step_count
      company.update(completed_step_count: (company.completed_step_count + 1))
    end

    def update_onboarding_status
      status = if company.step_count == company.completed_step_count
                'completed'
               else
                'in_progress'
               end

      company.update!(status: status)
    end

    def run_side_effects
      klass = related_class_name.classify.safe_constantize
      case related_class_type
      when 'service'
        klass.call(company)
      when 'worker'
        klass.perform_async(company_id)
      end
    end
end
