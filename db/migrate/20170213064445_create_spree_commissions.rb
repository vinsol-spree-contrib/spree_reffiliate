class CreateSpreeCommissions < ActiveRecord::Migration[4.2]
  def change
    create_table :spree_commissions do |t|
      t.references :affiliate, index: true

      t.datetime :start_date, index: true
      t.datetime :end_date, index: true
      t.boolean :paid, default: false, null: false
      t.decimal :total
      t.integer :transactions_count

      t.timestamps null: false
    end
  end
end
