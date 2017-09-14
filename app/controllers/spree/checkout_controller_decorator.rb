Spree::CheckoutController.class_eval do
  before_action :set_affilate, only: :update
  after_action :clear_session, only: :update

  private
    def set_affilate
      if @order.payment? && session[:affiliate]
        @order.affiliate = Spree::Affiliate.find_by(path: session[:affiliate])
      end
    end

    def clear_session
      session[:affiliate] = nil if @order.completed?
    end
end
