require 'spec_helper'

describe Spree::CommissionRule, type: :model do

  describe 'associations' do
    it { is_expected.to have_many(:affiliate_commission_rules).dependent(:restrict_with_error) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
