class CreateSpreeAffiliateCommissionRules < ActiveRecord::Migration
  def change
    create_table :spree_affiliate_commission_rules do |t|
      t.references :commission_rule
      t.references :affiliate

      t.decimal :rate
      t.decimal :fixed_commission
      t.boolean :active, default: false

      t.timestamp null: false
    end
  end
end
