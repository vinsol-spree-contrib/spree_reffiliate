require 'spec_helper'

describe Spree::StoreCredit, type: :model do

  let!(:referral_category) { FactoryGirl.create(:store_credit_category, name: "Referral Credit") }
  let!(:referral_store_credit) { FactoryGirl.create(:store_credit, category_id: referral_category.id) }
  let(:store_credit) { FactoryGirl.create(:store_credit) }

  describe 'associations' do
    it { is_expected.to have_one(:referred_record) }
  end

  describe 'private methods' do
    describe '#referral?' do
      context 'when category is referral category' do
        it 'returns true' do
          expect(referral_store_credit.send(:referral?)).to be_truthy
        end
      end

      context 'when category is not referral_category' do
        it 'returns false' do
          expect(store_credit.send(:referral?)).to be_falsey
        end
      end
    end

    describe '#send_credit_reward_information' do
      it 'sends mail' do
        expect{ store_credit.send(:send_credit_reward_information) }.to change{ ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end


end
