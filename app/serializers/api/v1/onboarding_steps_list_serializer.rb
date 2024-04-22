module Api
  module V1
    class OnboardingStepsListSerializer < ActiveModel::Serializer
      attributes :company_id, :title, :status, :step_count, :completed_step_count
      has_many :onboarding_steps
      belongs_to :user

      def company_id
        object.id
      end
    end
  end
end
