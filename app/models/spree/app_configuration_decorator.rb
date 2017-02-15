Spree::AppConfiguration.class_eval do
  preference :admin_affiliates_per_page, :integer, default: 10
  preference :admin_commissions_per_page, :integer, default: 10
  preference :admin_transactions_per_page, :integer, default: 10
end
