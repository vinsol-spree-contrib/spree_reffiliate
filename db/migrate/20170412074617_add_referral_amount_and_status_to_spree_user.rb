class AddReferralAmountAndStatusToSpreeUser < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_users, :referral_credits, :decimal
    add_column :spree_users, :referrer_benefit_enabled, :boolean, default: true
  end
end
