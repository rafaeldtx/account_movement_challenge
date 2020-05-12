class Transaction < ApplicationRecord
  belongs_to :account

  validates :account_id, :amount, presence: true
end
