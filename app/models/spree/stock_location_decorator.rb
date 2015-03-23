Spree::StockLocation.class_eval do
  include Spree::CalculatedAdjustments
  include Spree::AdjustmentSource

  def compute_amount(item)
    calculator.compute(item)
  end
end
