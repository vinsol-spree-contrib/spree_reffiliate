class CreateSpreeCommissionRules < ActiveRecord::Migration
  def change
    create_table :spree_commission_rules do |t|
      t.string :name
      t.text :description
      t.boolean :fixed_commission, null: false

      t.timestamps null: false
    end
  end
end
