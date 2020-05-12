require 'rails_helper'

describe Transaction do
  context('validations') do
    it { expect(subject).to validate_presence_of(:amount) }
    it { expect(subject).to validate_presence_of(:account_id) }
  end
end
