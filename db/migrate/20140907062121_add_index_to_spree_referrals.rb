class AddIndexToSpreeReferrals < ActiveRecord::Migration[4.2]
  def change
    add_index :spree_referrals, :user_id
  end
end
