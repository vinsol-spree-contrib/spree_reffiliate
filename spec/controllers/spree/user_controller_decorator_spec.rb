require 'spec_helper'

describe Spree::UsersController, type: :controller do
  let(:email) { 'mynew@email-address.com' }
  let(:admin_user) { create(:user) }
  let(:user) { create(:user, email: email) }
  let(:role) { create(:role) }
  let(:affiliate) { double(Spree::Affiliate) }
  let!(:referrable_user) { FactoryGirl.create(:user, email: FFaker::Internet.email, referral_credits: 50, referrer_benefit_enabled: true) }
  let!(:referral) { FactoryGirl.create(:referral, user_id: user.id, code: FFaker::Name.name) }
  let!(:referred_record) { FactoryGirl.create(:referred_record, user_id: user.id, referral_id: referrable_user.id) }

  before do
    allow(controller).to receive(:spree_current_user) { user }
    allow(Spree::Affiliate).to receive(:find_by) { affiliate }
    allow(Spree::User).to receive(:find_by) { user }
    allow(user).to receive(:can_activate_associated_partner=) { true }
    allow(affiliate).to receive(:email) { email }
  end

  context '#update' do
    context 'when updating own account' do
      it 'performs update' do
        spree_put :update, { user: { email: email }, activation_token: 'token' }
        expect(assigns[:user].email).to eq email
        expect(response).to redirect_to spree.account_url(only_path: true)
      end
    end

    it 'does not update roles' do
      spree_put :update, { user: { spree_role_ids: [role.id] } , activation_token: 'token' }
      expect(assigns[:user].spree_roles).to_not include role
    end

    context 'when Affilate not found' do
      before do
        allow(Spree::Affiliate).to receive(:find_by).and_return(nil)
      end

      it 'does redirect when no activation_token' do
        spree_put :update, { user: { spree_role_ids: [role.id] }, activation_token: 'token' }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#referral_details' do
    before { allow(controller).to receive(:spree_current_user) { referrable_user } }

    it 'lists all referrals of current user' do
      spree_get :referral_details
      expect(assigns(:referred_records).first).to eq(referred_record)
    end
  end
end
