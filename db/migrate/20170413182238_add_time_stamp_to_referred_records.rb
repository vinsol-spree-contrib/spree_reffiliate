class AddTimeStampToReferredRecords < ActiveRecord::Migration[4.2]
  def change
    add_timestamps(:spree_referred_records)
  end
end
