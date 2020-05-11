class Account < ApplicationRecord
  validates :number,
            :amount,
            presence: true, numericality: { only_integer: true }
end
