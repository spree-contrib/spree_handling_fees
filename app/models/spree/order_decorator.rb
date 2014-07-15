Spree::Order.class_eval do

  self.state_machine.after_transition to: :payment, do: :apply_handling_fee

  def apply_handling_fee
    self.clear_handling_fees
    label = "Handling Fee"
    self.shipments.each do |shipment|
      shipment.shipping_method.shipping_categories.each do |shipping_category|
        shipping_category.handling_fees.each do |handling_fee|
          handling_fee.create_adjustment(label, self, shipment)
        end
      end
    end
  end

  def clear_handling_fees
    adjustments.handling.destroy_all
  end

  def handling_total
    adjustments.handling.map(&:amount).sum
  end

end