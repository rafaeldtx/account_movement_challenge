class Account < ApplicationRecord
  has_many :transactions

  validates :number,
            :amount,
            presence: true, numericality: { only_integer: true }

  validates_uniqueness_of :number
end
