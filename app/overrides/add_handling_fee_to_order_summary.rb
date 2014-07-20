Deface::Override.new(
  name: "add_handling_fee_to_stock_location",
  virtual_path: "spree/checkout/_summary",
  insert_after: "[data-hook='order_details_shipment_promotion_adjustments']",
  partial: "spree/handling_fee_in_order_summary"
)