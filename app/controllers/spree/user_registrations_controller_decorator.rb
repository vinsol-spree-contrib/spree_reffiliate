Spree::UserRegistrationsController.class_eval do
  before_action :check_referral_and_affiliate, only: :create
  after_action :reset_affiliate_session, only: :create

  def check_referral_and_affiliate
    params[:spree_user].merge!(referral_code: session[:referral], affiliate_code: session[:affiliate])
  end

  def reset_affiliate_session
    session[:affiliate] = nil if @user.persisted?
  end
end
