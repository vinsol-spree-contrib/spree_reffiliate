class AddAffiliateToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :affiliate_id ,:integer

    add_index :spree_orders, :affiliate_id
  end
end
