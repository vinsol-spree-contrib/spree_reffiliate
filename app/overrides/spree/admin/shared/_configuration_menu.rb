Deface::Override.new(
  virtual_path: "spree/admin/shared/sub_menu/_configuration",
  name: "admin_content_admin_configuration_menu_parser",
  insert_bottom: "[data-hook='admin_configurations_sidebar_menu']",
  text: "<%= configurations_sidebar_menu_item Spree.t(:affiliates), admin_affiliates_path %>
       <%= configurations_sidebar_menu_item Spree.t(:name, scope: :referral), edit_admin_referral_settings_path %>"
)
