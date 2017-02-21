require 'spec_helper'

describe Spree::CommissionTransaction, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:affiliate).class_name('Spree::Affiliate') }
    it { is_expected.to belong_to(:commission).class_name('Spree::Commission').counter_cache(:transactions_count) }
    it { is_expected.to belong_to(:commissionable) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:commission) }
  end

   describe 'ransack attributes and associations' do
    it { expect(subject.whitelisted_ransackable_attributes).to include('amount', 'created_at') }
  end
end
