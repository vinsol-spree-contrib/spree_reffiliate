Deface::Override.new(
  virtual_path: "spree/users/show",
  name: "user_info",
  insert_after: "[data-hook='account_summary'] #user-info dd:first",
  partial: 'spree/users/referral_links'
)

Deface::Override.new(
  virtual_path: 'spree/users/show',
  name: 'user_transactions_info',
  insert_after: "[data-hook='account_my_orders']",
  partial: 'spree/users/transactions'
)
