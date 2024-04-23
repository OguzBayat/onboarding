class Api::V1::BaseApiController < ActionController::API
  def me
    render json: current_company, serializer: Api::V1::IamSerializer
  end

  def current_company
    @current_company = Company.find(params[:company_id])
  end
end
