require 'spec_helper'

describe Spree::Commission, type: :model do

  describe 'associations' do
    it { is_expected.to have_many(:transactions).class_name('Spree::CommissionTransaction').dependent(:restrict_with_error) }
    it { is_expected.to belong_to(:affiliate).class_name('Spree::Affiliate') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
  end

  describe 'ransack attributes and associations' do
    it { expect(subject.whitelisted_ransackable_attributes).to include('start_date', 'end_date', 'paid') }
    it { expect(subject.whitelisted_ransackable_associations).to include('affiliate') }
  end
end
