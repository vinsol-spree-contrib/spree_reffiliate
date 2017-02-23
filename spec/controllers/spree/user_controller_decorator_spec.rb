require 'spec_helper'

describe Spree::UsersController, type: :controller do
  let(:email) { 'mynew@email-address.com' }
  let(:admin_user) { create(:user) }
  let(:user) { create(:user, email: email) }
  let(:role) { create(:role) }
  let(:affiliate) { double(Spree::Affiliate) }

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

end
