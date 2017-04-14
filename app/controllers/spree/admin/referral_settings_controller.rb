module Spree
  module Admin
    class ReferralSettingsController < ResourceController
      before_action :check_credit_amount, only: :update

      def update
        Spree::Config[:referrer_benefit_enabled] = params[:referrer_benefit_enabled] == '1' ? true : false
        Spree::Config[:referral_credits] = params[:referral_credits]
        flash[:success] = Spree.t(:successful_update, scope: :referral_settings)
        redirect_to edit_admin_referral_settings_path
      end

      private

      def check_credit_amount
        if params[:referral_credits].to_i < 0
          flash[:error] = Spree.t(:unsuccessful_update, scope: :referral_settings)
          redirect_to edit_admin_referral_settings_path
        end
      end
    end
  end
end
