Deface::Override.new(
  virtual_path: "spree/admin/users/index",
  name: "referral_code_header",
  insert_before: "[data-hook='admin_users_index_headers'] th:nth-child(2)",
  text: "<th>Referrals</th>",
  original: 'bf55c1268f7e2d1eceee7797967a644b271c96fb'
)
Deface::Override.new(
  virtual_path: "spree/admin/users/index",
  name: "referral_code",
  insert_before: "[data-hook='admin_users_index_rows'] td:nth-child(2)",
  text: "<td><%= user.referred_count %></td>",
  original: '511aac3073f5db1abe7fbedf57aaf870f0c3618f'
)
