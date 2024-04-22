class Api::V1::SyncProgressInfosController < ApplicationController

  def index
    service_result = ProgressInfoService.call(current_company)

    if service_result
      render json: {
        data: service_result,
        status: 200,
        type: 'Success'
      }
    else
      render json: { errors: service_result.errors.messages }, status: :unprocessable_entity
    end
  end

  private
    def current_company
      @current_company = Company.find(params[:company_id])
    end
end
