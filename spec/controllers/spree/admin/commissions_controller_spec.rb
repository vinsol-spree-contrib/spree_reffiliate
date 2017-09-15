require 'spec_helper'
describe Spree::Admin::CommissionsController, type: :controller do
  stub_authorization!

  describe '#pay' do
    before do
      @affiliate = double(Spree::Affiliate, id: 1)
      @commission = double(Spree::Commission, id: 1)
      @commissions = [@commission]
      allow(Spree::Affiliate).to receive(:find_by).and_return(@affiliate)
      allow(@affiliate).to receive(:commissions).and_return(@commissions)
      allow(@commissions).to receive(:find).and_return(@commission)
      allow(Spree::Commission).to receive(:find_by).and_return(@commission)
      allow(@commission).to receive(:mark_paid!).and_return(true)
      allow(@affiliate).to receive(:to_param).and_return(1)
    end

    def send_request(options = {})
      patch :pay, { affiliate_id: 1, id: 1 }.merge(options)
    end

    it "expect to redirect to commissions listing" do
      send_request()
      expect(response).to redirect_to admin_affiliate_commissions_path
    end

    it "expect to redirect to commissions listing" do
      send_request()
      expect(flash[:success]).to eql(Spree.t(:mark_paid_successfully, scope: :commission))
    end

    context 'when mark_paid return false(not marked paid)' do
      before do
        allow(@commission).to receive(:mark_paid!).and_return(false)
      end

      it "expect to redirect to commission listing" do
        send_request()
        expect(response).to redirect_to admin_affiliate_commissions_path
      end

      it "expect to redirect to commissions listing" do
        send_request()
        expect(flash[:error]).to eql(Spree.t(:mark_paid_failure, scope: :commission))
      end
    end
  end
end
