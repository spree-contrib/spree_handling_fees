Spree::OrderUpdater.class_eval do
  def update_adjustment_total
    recalculate_adjustments
    order.adjustment_total = line_items.sum(:adjustment_total) +
                             shipments.sum(:adjustment_total)  +
                             adjustments.eligible.sum(:amount)
    order.included_tax_total = line_items.sum(:included_tax_total) + shipments.sum(:included_tax_total)
    order.additional_tax_total = line_items.sum(:additional_tax_total) + shipments.sum(:additional_tax_total)
    order.handling_total = shipments.sum(:handling_total)

    update_order_total
  end  
end
