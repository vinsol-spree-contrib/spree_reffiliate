module Spree
  class Affiliate::ConfirmationsController < Spree::BaseController

    prepend_before_action :load_user, :load_affiliate, only: :new

    def new
      redirect_to root_path, error: Spree(:not_found) unless @affiliate
    end


    private
      def load_affiliate
        @affiliate = Spree::Affiliate.find_by(activation_token: params[:activation_token])
        redirect_to root_path, error: Spree.t(:activation_token_expired) unless @affiliate
      end

      def load_user
        @user = Spree::User.find_by(email: @affiliate.email)
      end
  end
end
