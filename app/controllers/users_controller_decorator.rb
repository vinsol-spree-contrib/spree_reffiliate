Spree::UsersController.class_eval do

  prepend_before_action :affiliate_user, only: :update

  private
    def load_object
      if @affiliate
        @user ||= @affiliate_user
      else
        @user ||= spree_current_user
        authorize! params[:action].to_sym, @user
      end
    end

    def affiliate_user
      if params[:activation_token]
        @affiliate ||= Spree::Affiliate.find_by(activation_token: params[:activation_token])
        (redirect_to root_path, error: Spree.t(:affiliate_not_found) and return) unless @affiliate
        @affiliate_user ||= Spree::User.find_by(email: @affiliate.email)
        @affiliate_user.can_activate_associated_partner = true
      end
    end
end
