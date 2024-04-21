class Api::V1::SyncProgressInfosController < ApplicationController
  before_action :warehouse_progress_infos, :product_progress_infos, :vendor_progress_infos, :sales_history_progress_infos
  def index
    all_infos = @warehouse_progress_infos + @product_progress_infos + @vendor_progress_infos + @sales_history_progress_infos
    render json: {
      data: {
        total_progress_ratio: calculate_progress_ratio(all_infos),
        warehouse_progress_ratio: calculate_progress_ratio(@warehouse_progress_infos),
        product_progress_ratio: calculate_progress_ratio(@product_progress_infos),
        vendor_progress_ratio: calculate_progress_ratio(@vendor_progress_infos),
        sales_history_progress_ratio: calculate_progress_ratio(@sales_history_progress_infos),
        fetched_warehouse_count: @warehouse_progress_infos.first[:fetched_count],
        fetched_product_count: @product_progress_infos.first[:fetched_count],
        fetched_vendors_count: @vendor_progress_infos.first[:fetched_count],
        fetched_sales_history_count: @sales_history_progress_infos.first[:fetched_count]
      },
      status: 200,
      type: 'Success'
    }
  end

  private
    def current_company
      @current_company = Company.find(params[:company_id])
    end

    # Assume that these all fetcher return array
    def warehouse_progress_infos
      # @warehouse_progress_infos = WarehouseFetcher.new(current_company).progress
      @warehouse_progress_infos = [{ number_of_total_process: 2, fetched_count: 2 }]
    end

    def product_progress_infos
      # @product_progress_infos = ProductFetcher.new(current_company).progress
      @product_progress_infos = [{ number_of_total_process: 50, fetched_count: 25 }]
    end

    def vendor_progress_infos
      # @vendor_progress_infos = VendorFetcher.new(current_company).progress
      @vendor_progress_infos = [{ number_of_total_process: 225, fetched_count: 45 }]
    end

    def sales_history_progress_infos
      # @sales_history_progress_infos = SalesHistoryFetcher.new(current_company).progress
      @sales_history_progress_infos = [{ number_of_total_process: 225, fetched_count: 45 }]
    end

    def calculate_progress_ratio(arr)
      uniq_keys = arr.map(&:keys).flatten.uniq
      total_counts = uniq_keys.map { |k| [k, arr.map { |h| h[k] }.compact.sum] }.to_h
      (total_counts[:fetched_count].to_f/total_counts[:number_of_total_process].to_f).round(2)
    end
end
