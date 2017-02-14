class CreateSpreeCommissionTransactions < ActiveRecord::Migration
  def change
    create_table :spree_commission_transactions do |t|
      t.references :affiliate
      t.references :commission

      t.decimal :amount
      t.boolean :locked

      t.references :commissionable, polymorphic: true

      t.timestamps null: false
    end
  end
end
