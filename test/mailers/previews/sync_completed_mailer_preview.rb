# Preview all emails at http://localhost:3000/rails/mailers/sync_completed_mailer
class SyncCompletedMailerPreview < ActionMailer::Preview
  def sync_completed_email
    progress_info = {
                      "company_id": 1,
                      "total_progress_ratio": 1.0,
                      "warehouse_progress_ratio": 1.0,
                      "product_progress_ratio": 1.0,
                      "vendor_progress_ratio": 1.0,
                      "sales_history_progress_ratio": 1.0,
                      "fetched_warehouse_count": 2,
                      "fetched_product_count": 25,
                      "fetched_vendors_count": 45,
                      "fetched_sales_history_count": 45
                    }
    SyncCompletedMailer.sync_completed_email(User.first, progress_info)
  end
end
