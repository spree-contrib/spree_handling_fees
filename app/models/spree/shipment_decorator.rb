Spree::Shipment.class_eval do

  # Override if you want to create custom situations for applying the handling charge
  def needs_handling_charge?
    true
  end

end
