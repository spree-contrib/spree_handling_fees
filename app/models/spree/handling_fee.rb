class Spree::HandlingFee < ActiveRecord::Base
  include Spree::Core::CalculatedAdjustments
  
  has_one :calculator, class_name: "Spree::Calculator", as: :calculable, dependent: :destroy
  belongs_to :shipping_category, class_name: "Spree::ShippingCategory"
  
  after_initialize :set_default_calculator
  
  def set_default_calculator
    self.calculator_type = "Spree::Calculator::Shipping::HandlingCharge"
    self.save
  end

  def create_adjustment(label, target, calculable, mandatory=false, state="closed")
    calculable = calculable.to_package if calculable.is_a?(Spree::Shipment)
    amount = compute_amount(calculable)
    return if amount == 0 && !mandatory
    target.adjustments.create(
    :amount => amount,
    :source => self,
    :label => label,
    :mandatory => mandatory,
    :state => state
    )
  end
  
  # Updates the amount of the adjustment using our Calculator and calling the +compute+ method with the +calculable+
  # referenced passed to the method.
  def update_adjustment(adjustment, calculable)
    calculable = calculable.to_package if calculable.is_a?(Spree::Shipment)
    adjustment.update_column(:amount, compute_amount(calculable))
  end
 
  # Calculate the amount to be used when creating an adjustment
  # NOTE: May be overriden by classes where this module is included into.
  # Such as Spree::Promotion::Action::CreateAdjustment.
  def compute_amount(calculable)
    self.calculator.compute(calculable)
  end
  
end
