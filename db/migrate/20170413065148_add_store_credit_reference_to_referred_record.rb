class AddStoreCreditReferenceToReferredRecord < ActiveRecord::Migration[4.2]
  def change
    add_reference :spree_referred_records, :store_credit, index: true
  end
end
