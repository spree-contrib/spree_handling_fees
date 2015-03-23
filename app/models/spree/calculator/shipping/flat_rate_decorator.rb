Spree::Calculator::Shipping::FlatRate.class_eval do
  def compute_shipment(shipment)
    self.preferred_amount
  end
end
