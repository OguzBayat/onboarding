class User < ApplicationRecord
  has_one :company

  validates :name, :surname, presence: true
  validates :email, uniqueness: true

  def fullname
    name << " " << surname
  end
end
