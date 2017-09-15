require 'spec_helper'

describe Spree::CheckoutController, type: :controller do

  let(:order) { create(:order_with_totals, email: nil, user: nil) }
  let(:user)  { build(:user, spree_api_key: 'fake') }
  let(:token) { 'some_token' }
  let!(:affiliate_session) { 'affiliate_session' }
  let!(:shipment) { create(:shipment) }


  before do
    allow(controller).to receive(:current_order) { order }
    allow(order).to receive(:confirmation_required?) { true }
    allow(order).to receive(:payment?).and_return(true)
  end

  describe '#update' do
    let(:address) { double Spree::Address }
    let(:orders) { double ActiveRecord::Relation }
    let!(:payment_method) { double(Spree::PaymentMethod, id: 1) }
    let(:payment_method_id) { payment_method.id }

    before do
      allow(controller).to receive(:current_order).with(lock: true).and_return(order)
      allow(controller).to receive(:current_order).and_return(order)
      allow(order).to receive(:can_go_to_state?).with("delivery").and_return(false)
      allow(order).to receive(:state).and_return("delivery")
      allow(order).to receive(:state=).with("delivery").and_return(order)
      allow(order).to receive(:completed?).and_return(false)
      allow(order).to receive(:checkout_allowed?).and_return(true)
      allow(order).to receive(:insufficient_stock_lines).and_return(false)
      allow(order).to receive(:has_checkout_step?).and_return(true)
      allow(order).to receive(:bill_address).and_return(address)
      allow(order).to receive(:checkout_steps).and_return(["address", "payment", "completed"])
      allow(order).to receive(:user).and_return(user)
      allow(controller).to receive(:try_spree_current_user).and_return(user)
      allow(order).to receive(:email).and_return('abc@example.com')
      allow(user).to receive(:orders).and_return(orders)
      allow(orders).to receive(:incomplete).and_return(orders)
      allow(orders).to receive(:where).with('id != ?', order.id).and_return([order])
      allow(order).to receive(:affiliate=)
      allow(controller.session).to receive(:[])
      allow(controller.session).to receive(:[]).with(:affiliate).and_return(affiliate_session)
    end

    def send_request(options = {})
      patch :update, { "order"=>{ payments_attributes: [{ payment_method_id: payment_method_id }] }, "commit"=>"Save and Continue", "state"=>"delivery" }.merge(options)
    end

    it do
      expect(order).to receive(:payment?).and_return(true)
      send_request
    end

    it do
      expect(controller.session).to receive(:[]).with(:affiliate).and_return(affiliate_session)
      send_request
    end

    context 'when order is complete' do
      before do
        allow(order).to receive(:completed?).and_return(true)
        allow(order).to receive_message_chain(:shipment, :stock_location, :fill_status)
        allow(order).to receive_message_chain(:shipment, :stock_location, :unstock)
        allow(order).to receive_message_chain(:shipment, :stock_location, :stock)
      end

      it do
        expect(order).to receive(:completed?).and_return(true)
        send_request({ shipments_attributes: { id: shipment.id } })
      end

      it do
        expect(controller.session).to receive(:[]=).with(:affiliate, nil).and_return(nil)
        send_request({ shipments_attributes: { id: shipment.id } })
      end
    end
  end
end
