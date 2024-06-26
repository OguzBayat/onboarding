class Company < ApplicationRecord
  belongs_to :user
  has_many :onboarding_steps, -> { order(step_order: :asc) }

  validates :title, presence: true
  validates_inclusion_of :status, in: %w(not_start in_progress completed)
end
