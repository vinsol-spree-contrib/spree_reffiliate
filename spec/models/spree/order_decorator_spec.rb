require 'spec_helper'

describe Spree::Order, type: :model do

  describe 'associations' do
    it { is_expected.to have_many(:transactions).class_name('Spree::CommissionTransaction').dependent(:restrict_with_error) }
    it { is_expected.to belong_to(:affiliate).class_name('Spree::Affiliate') }
  end
end
