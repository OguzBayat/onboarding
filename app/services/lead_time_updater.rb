#dummy class to use at step update

class LeadTimeUpdater
  attr_reader :company
  def initialize(company)
    @company = company
  end

  def self.call(company)
    true
  end
end
