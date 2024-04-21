module Api
  module V1
    class OnboardingStepsListSerializer < ActiveModel::Serializer
      attributes :company_id, :title, :onboarding_completed
      has_many :onboarding_steps
      belongs_to :user

      def company_id
        object.id
      end
    end
  end
end
