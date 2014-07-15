class Spree::Calculator::Shipping::HandlingCharge < Spree::ShippingCalculator
  preference :per_order_charge, :decimal, default: 1.90
  preference :per_item_charge, :decimal, default: 0.40
  
  def self.description
    "McSweeney's Handling Charge"
  end

  def available?(package)
    package.shipping_categories.each do |shipping_category|
      return true if !shipping_category.handling_fees.include?(self.calculable)
    end
    # If none of the shipping categories have handling fees
    return false
  end

  def compute(package)
    self.preferred_per_order_charge + (self.preferred_per_item_charge * (package.quantity - 1))
  end
end
