require 'securerandom'

FactoryBot.define do
  factory :account do
    amount { 150000 }
    number { 12345 }
  end
end
