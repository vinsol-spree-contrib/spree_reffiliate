Spree::UserRegistrationsController.class_eval do

  before_action :check_referral_and_affiliate, only: :create
  after_action :reset_referral_session, only: :create
  after_action :reset_affiliate_session, only: :create

  private

  def check_referral_and_affiliate
    params[:spree_user].merge!(referral_code: session[:referral], affiliate_code: session[:affiliate])
  end

  def reset_referral_session
    if @user.persisted?
      session[:referral] = nil
    end
  end

  def reset_affiliate_session
    if @user.persisted? && @user.affiliate? && @user.affiliate.affiliate_commission_rules.order_placement.active.blank?
      session[:affiliate] = nil
    end
  end

end
