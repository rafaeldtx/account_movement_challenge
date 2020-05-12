FactoryBot.define do
  factory :transaction do
    amount { 20000 }
    account { create(:account) }
  end
end
