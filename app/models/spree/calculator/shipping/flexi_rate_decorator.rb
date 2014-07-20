Spree::Calculator::Shipping::FlexiRate.class_eval do
  def compute_shipment(shipment)
    self.compute_package(shipment.to_package)
  end
end
