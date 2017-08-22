class AddTimeStampToReferredRecords < ActiveRecord::Migration
  def change
    add_timestamps(:spree_referred_records)
  end
end
