class Api::V1::OnboardingStepsController < ApplicationController
  before_action :set_onboarding_step, only: %i[show update]

  # GET :company_id/onboarding_steps
  def index
    @onboarding_steps = current_company.onboarding_steps.order(step_order: :asc)

    render json: @onboarding_steps
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
      render json: @onboarding_step.errors, status: :unprocessable_entity
    end
  end

  private
    def current_company
      @current_company = Company.find(params[:company_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_onboarding_step
      @onboarding_step = current_company.onboarding_steps.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def onboarding_step_params
      params.require(:onboarding_step).permit(:locked, :step_input)
    end
end
