module Spree
  class Affiliate::ConfirmationsController < Spree::UsersController

    prepend_before_action :load_object, :load_affiliate, only: [:new, :create]

    def new
      redirect_to root_path, error: Spree(:not_found, scope: :affiliate_confirmation) unless @affiliate
    end

    def create
      @user.can_activate_associated_partner = true
      if @user.update_attributes(user_params)
        if params[:user][:password].present?
          sign_in(@user, :event => :authentication, :bypass => !Spree::Auth::Config[:signout_after_password_change])
        end
        redirect_to spree.account_url, :notice => Spree.t(:account_updated)
      else
        render :edit
      end
    end


    private
      def load_affiliate
        @affiliate = Spree::Affiliate.find_by(activation_token: params[:activation_token])
        redirect_to root_path, error: Spree.t(:activation_token_expired) unless @affiliate
      end

      def load_object
        @user = Spree::User.find_by(email: @affiliate.email)
        redirect_to root_path, error: Spree.t(:user_not_found) unless @user
      end
  end
end
