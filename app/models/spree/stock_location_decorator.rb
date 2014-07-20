Spree::StockLocation.class_eval do
  include Spree::Core::CalculatedAdjustments
  include Spree::Core::AdjustmentSource

  def compute_amount(item)
    calculator.compute(item)
  end
end