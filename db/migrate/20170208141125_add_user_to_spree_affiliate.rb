class AddUserToSpreeAffiliate < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_affiliates, :email, :string
    add_column :spree_affiliates, :active, :boolean, default: false
    add_column :spree_affiliates, :activation_token, :string
    add_column :spree_affiliates, :activated_at, :datetime

    add_index :spree_affiliates, :email
    add_index :spree_affiliates, :active
  end
end
