class CreateSpreeCommissions < ActiveRecord::Migration
  def change
    create_table :spree_commissions do |t|
      t.references :affiliate

      t.datetime :start_date
      t.datetime :end_date
      t.boolean :paid, default: false, null: false
      t.decimal :total

      t.timestamps null: false
    end
  end
end
