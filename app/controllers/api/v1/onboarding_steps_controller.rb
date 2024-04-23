class Api::V1::OnboardingStepsController < Api::V1::BaseApiController
  before_action :set_onboarding_step, only: %i[show update]

  # GET :company_id/onboarding_steps
  def index
    render json: ActiveModelSerializers::SerializableResource.new(current_company, each_serializer: Api::V1::OnboardingStepsListSerializer)
  rescue ActiveRecord::RecordNotFound => error
    render json: { error: error.message }, status: :not_found
  end

  # GET :company_id/onboarding_steps/:id
  def show
    render json: @onboarding_step
  end

  # PUT :company_id/onboarding_steps/:id
  def update
    if @onboarding_step.update(onboarding_step_params)
      render json: @onboarding_step
    else
      render json: { error: @onboarding_step.errors.to_hash }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_onboarding_step
      @onboarding_step = current_company.onboarding_steps.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
      render json: { error: error.message }, status: :not_found
    end

    # Only allow a list of trusted parameters through.
    def onboarding_step_params
      params.require(:onboarding_step).permit(:step_input, :completed).with_defaults(completed: true)
    end
end
