require 'spec_helper'

describe Spree::User, type: :model do
  before(:each) do
    @user = FactoryGirl.create(:user, email: FFaker::Internet.email, referral_credits: 50, referrer_benefit_enabled: true)
    @referred = FactoryGirl.create(:user, email:  FFaker::Internet.email, referral_code: @user.referral.code, referral_credits: 50, referrer_benefit_enabled: true)
    @affiliate = Spree::Affiliate.create(name: FFaker::Name.name, path: FFaker::Name.name)
    @affiliated = FactoryGirl.create(:user, email:  FFaker::Internet.email, affiliate_code: @affiliate.path)
    Spree::Config[:referrer_benefit_enabled] = true
    Spree::StoreCredit::REFERRAL_STORE_CREDIT_CATEGORY = 'Referal Category'
  end
  context "referral user" do
    it "has a referral record" do
      expect(@user.referral).not_to be_nil
    end
    it "has a referral code" do
      expect(@user.referral.code).not_to be_nil
    end
    it "has a referral count" do
      expect(@user.referred_count).to eq(1)
    end
    it "has referred users" do
      expect(@user.referral.referred_users).to eq([@referred])
    end
    it "has referred records" do
      expect(@user.referral.referred_records).to eq([@referred.referred_record])
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:transactions).class_name('CommissionTransaction').dependent(:restrict_with_error) }
  end

  context "referred user" do
    it "has a referred user" do
      expect(@referred.referred_by).to eq(@user)
    end
    it "has a referred record" do
      expect(@referred.referred_record).to eq(@user.referral.referred_records.first)
    end
    it "returns boolean if referred" do
      expect(@referred.referred?).to be_truthy
      expect(@user.referred?).to be_falsy
    end
  end

  context "affiliated user" do
    it "has an affiliate" do
      expect(@affiliated.affiliate).to eq(@affiliate)
    end
    it "returns boolean if affiliated" do
      expect(@affiliated.affiliate?).to be_truthy
    end
    it "returns an affiliated record" do
      expect(@affiliated.affiliate_record).to eq(@affiliate.referred_records.first)
    end
  end
end
