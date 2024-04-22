module Api
  module V1
    class OnboardingStepSerializer < ActiveModel::Serializer
      attributes :id, :company_id, :title, :description, :video_info,
                 :step_order, :locked, :completed_at, :step_input, :completed

      belongs_to :company
    end
  end
end
