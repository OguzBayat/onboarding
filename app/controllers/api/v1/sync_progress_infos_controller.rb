class Api::V1::SyncProgressInfosController < Api::V1::BaseApiController

  def index
    service_result = ProgressInfoService.call(current_company)

    if service_result
      render json: service_result
    else
      render json: { errors: service_result.errors.messages }, status: :unprocessable_entity
    end
  end
end
