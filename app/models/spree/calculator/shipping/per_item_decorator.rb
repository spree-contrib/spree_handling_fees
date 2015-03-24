Spree::Calculator::Shipping::PerItem.class_eval do
  def compute_shipment(shipment)
    # DD: could probably call compute_from_price here
    compute_package(shipment.to_package)
  end
end
