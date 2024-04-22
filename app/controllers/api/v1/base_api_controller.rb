class Api::V1::BaseApiController < ActionController::API
  def current_company
    @current_company = Company.find(params[:company_id])
  end
end
