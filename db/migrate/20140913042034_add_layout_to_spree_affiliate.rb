class AddLayoutToSpreeAffiliate < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_affiliates, :layout, :string
  end
end
