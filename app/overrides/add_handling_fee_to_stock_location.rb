Deface::Override.new(
  name: "add_handling_fee_to_stock_location",
  virtual_path: "spree/admin/stock_locations/_form",
  insert_bottom: "[data-hook='admin_stock_locations_form_fields']",
  text: '<div data-hook="admin_stock_location_form_calculator_fields" class="omega six columns"><%= render partial: "spree/admin/shared/calculator_fields", locals: { f: f } %></div>'
)