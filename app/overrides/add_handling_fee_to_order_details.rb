Deface::Override.new(
  name: "add_handling_fee_to_stock_location",
  virtual_path: "spree/shared/_order_details",
  insert_after: "tfoot#shipment-total",
  partial: "spree/handling_fee_in_order_details"
)