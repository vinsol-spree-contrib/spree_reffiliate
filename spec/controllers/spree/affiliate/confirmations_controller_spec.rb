require 'spec_helper'
describe Spree::Affiliate::ConfirmationsController, type: :controller do
  stub_authorization!
  let!(:user) { double(Spree::User).as_null_object }


  describe '#new' do
    before do
      @affiliate = double(Spree::Affiliate)
      allow(Spree::Affiliate).to receive(:find_by).and_return(@affiliate)
      allow(@affiliate).to receive(:email).and_return('test@vinsol.com')
      allow(Spree::User).to receive(:find_by).and_return(user)
    end

    def send_request(options = {})
      get :new, { activation_token: "token" }.merge(options)
    end

    it "expect to render new" do
      send_request()
      expect(response).to render_template(:new)
    end

    context 'when affiliate not found' do
      before do
        allow(Spree::Affiliate).to receive(:find_by).and_return(nil)
      end

      it "expect to redirect" do
        send_request()
        expect(response).to redirect_to root_path
      end
    end

    context 'when affiliate found' do
      context 'when user not found' do
        before do
          allow(Spree::User).to receive(:find_by).and_return(nil)
        end

        it "expect to redirect" do
          send_request()
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
