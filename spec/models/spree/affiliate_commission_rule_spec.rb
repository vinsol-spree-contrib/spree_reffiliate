require 'spec_helper'

describe Spree::AffiliateCommissionRule, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:affiliate).class_name('Spree::Affiliate') }
    it { is_expected.to belong_to(:commission_rule).class_name('Spree::CommissionRule') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:affiliate) }
    it { is_expected.to validate_presence_of(:commission_rule) }
    it { is_expected.to validate_presence_of(:rate) }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:assign_type_of_commission).before(:create) }
  end
end
