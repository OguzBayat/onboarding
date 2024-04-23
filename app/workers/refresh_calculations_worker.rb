#dummy class to use at step update

class RefreshCalculationsWorker
  include Sidekiq::Job

  def perform(company_id)
    company = Company.find(company_id)
    true
  end
end
