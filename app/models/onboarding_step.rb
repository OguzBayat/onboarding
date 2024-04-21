class OnboardingStep < ApplicationRecord
  belongs_to :company
  default_scope { order(step_order: :asc) }

  validates :title, :description, :video_info, :step_order, presence: true
end
