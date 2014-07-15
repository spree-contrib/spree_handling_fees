Deface::Override.new(
  name: "add_handling_fee_to_configuration_menu_sidebar",
  virtual_path: "spree/admin/shared/_configuration_menu",
  insert_bottom: "[data-hook='admin_configurations_sidebar_menu']",
  text: %q{<%= configurations_sidebar_menu_item Spree.t(:handling_fees), admin_handling_fees_path %>},
  original: '827b0026f704d7c96a4e7c312dba44b95c921f3d'
)