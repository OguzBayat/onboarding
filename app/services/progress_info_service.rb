class ProgressInfoService
  attr_reader :company
  def initialize(company)
    @company = company
  end

  def self.call(company)
    all_infos = warehouse_progress_infos(company) + product_progress_infos(company) + vendor_progress_infos(company) + sales_history_progress_infos(company)
    {
      company_id: company.id,
      total_progress_ratio: calculate_progress_ratio(all_infos),
      warehouse_progress_ratio: calculate_progress_ratio(warehouse_progress_infos(company)),
      product_progress_ratio: calculate_progress_ratio(product_progress_infos(company)),
      vendor_progress_ratio: calculate_progress_ratio(vendor_progress_infos(company)),
      sales_history_progress_ratio: calculate_progress_ratio(sales_history_progress_infos(company)),
      fetched_warehouse_count: warehouse_progress_infos(company).first[:fetched_count],
      fetched_product_count: product_progress_infos(company).first[:fetched_count],
      fetched_vendors_count: vendor_progress_infos(company).first[:fetched_count],
      fetched_sales_history_count: sales_history_progress_infos(company).first[:fetched_count]
    }
  end

  # Assume that these all fetcher return array
  def self.warehouse_progress_infos(company)
    # WarehouseFetcher.new(company).progress
    [{ company_id: company.id, number_of_total_process: 10, fetched_count: 2 }]
  end

  def self.product_progress_infos(company)
    # ProductFetcher.new(company).progress
    [{ company_id: company.id, number_of_total_process: 50, fetched_count: 25 }]
  end

  def self.vendor_progress_infos(company)
    # VendorFetcher.new(company).progress
    [{ company_id: company.id, number_of_total_process: 225, fetched_count: 45 }]
  end

  def self.sales_history_progress_infos(company)
    # SalesHistoryFetcher.new(company).progress
    [{ company_id: company.id, number_of_total_process: 225, fetched_count: 45 }]
  end

  def self.calculate_progress_ratio(arr)
    uniq_keys = arr.map(&:keys).flatten.uniq
    total_counts = uniq_keys.map { |k| [k, arr.map { |h| h[k] }.compact.sum] }.to_h
    (total_counts[:fetched_count].to_f/total_counts[:number_of_total_process].to_f).round(2)
  end
end
