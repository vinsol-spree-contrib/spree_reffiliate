class AddReferralAmountAndStatusToSpreeUser < ActiveRecord::Migration
  def change
    add_column :spree_users, :referral_credits, :integer
    add_column :spree_users, :referrer_benefit_enabled, :boolean, default: false
  end
end
