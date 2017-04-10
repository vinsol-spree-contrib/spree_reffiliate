require 'spec_helper'

describe Spree::Affiliate, type: :model do
  it "should have a name" do
    affiliate = FactoryGirl.build(:affiliate, name: nil)
    expect(affiliate).to_not be_valid
  end
  it "should have a path" do
    affiliate = FactoryGirl.build(:affiliate, path: nil)
    expect(affiliate).to_not be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:transactions).class_name('Spree::CommissionTransaction').dependent(:restrict_with_error) }
    it { is_expected.to have_many(:commissions).class_name('Spree::Commission').dependent(:restrict_with_error) }
    it { is_expected.to have_many(:affiliate_commission_rules).class_name('Spree::AffiliateCommissionRule').dependent(:destroy) }
    it { is_expected.to have_many(:commission_rules).through(:affiliate_commission_rules).class_name('Spree::CommissionRule') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:path) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:affiliate_commission_rules) }
    it { is_expected.to validate_uniqueness_of(:email).allow_blank }
    it { is_expected.to validate_uniqueness_of(:path).allow_blank }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:create_user).before(:create) }
    it { is_expected.to callback(:process_activation).before(:create) }
    it { is_expected.to callback(:send_activation_instruction).after(:commit).on(:create) }
  end

  describe 'accept_nested_attributes_for' do
    it { is_expected.to accept_nested_attributes_for(:affiliate_commission_rules) }
  end

  describe 'ransack attributes' do
    it { expect(subject.whitelisted_ransackable_attributes).to include('name', 'email') }
  end

  context "with user" do
    before do
      @affiliate = FactoryGirl.create(:affiliate)
      @affiliated = FactoryGirl.create(:user, affiliate_code: @affiliate.path)
      @order = FactoryGirl.create(:order, user: @affiliated)
    end

    it "returns an array of user records" do
      expect(@affiliate.referred_users).to eq([@affiliated])
    end
    it "returns an array of referred orders" do
      expect(@affiliate.referred_orders).to eq([@order])
    end
    it "returns referred count" do
      expect(@affiliate.referred_count).to eq(1)
    end
    it "returns an array of referred orders" do
      expect(@affiliate.referred_records).to eq([@affiliated.affiliate_record])
    end
  end


  describe '#create_user' do
    context 'when user is persisted' do
      let(:email) { 'test@abc.com' }
      let!(:affiliate_role) { create(:role, name: 'affiliate') }
      let!(:user) { create(:user, email: email) }

      context 'when have affiliate role' do
        before do
          user.spree_roles << affiliate_role
          @affiliate = Spree::Affiliate.create(email: email, name: 'test', path: 'path')
        end

        it { expect(Spree::User.find_by(email: email).spree_roles.where(name: 'affiliate').count).to eq 1 }
      end

      context 'when does not have affiliate role' do
        before do
          @affiliate = Spree::Affiliate.create(email: email, name: 'test', path: 'path')
        end

        it { expect(Spree::User.find_by(email: email).spree_roles.where(name: 'affiliate').count).to eq 1 }
      end
    end

    context 'when user is not persisted' do
      let(:email) { 'test@abc.com' }
      let!(:affiliate_role) { create(:role, name: 'affiliate') }

      context 'when have affiliate role' do
         before do
          @affiliate = Spree::Affiliate.create(email: email, name: 'test', path: 'path')
        end

        it { expect(Spree::User.find_by(email: email).spree_roles.where(name: 'affiliate').count).to eq 1 }
      end

      context 'when does not have affiliate role' do
         before do
          @affiliate = Spree::Affiliate.create(email: email, name: 'test', path: 'path')
        end

        it { expect(Spree::User.find_by(email: email).spree_roles.where(name: 'affiliate').count).to eq 1 }
      end
    end
  end
end
