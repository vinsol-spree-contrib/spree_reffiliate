require 'spec_helper'

describe Spree::CheckoutController, type: :controller do
  stub_authorization!

  describe '#update' do
    before do
      @order = double(Spree::Order)
      allow(@order).to receive(:payment?).and_return(true)
    end
  end
end
