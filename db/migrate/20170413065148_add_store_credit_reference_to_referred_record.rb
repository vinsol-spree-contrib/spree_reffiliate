class AddStoreCreditReferenceToReferredRecord < ActiveRecord::Migration
  def change
    add_reference :spree_referred_records, :store_credit, index: true
  end
end
