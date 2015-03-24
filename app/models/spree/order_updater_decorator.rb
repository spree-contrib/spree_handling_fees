Spree::OrderUpdater.class_eval do

  module OverrideOrderUpdater
    def update_adjustment_total
      super
      order.handling_total = shipments.sum(:handling_total)
      update_order_total
    end

    def update_order_total
      super
      order.total = order.total + order.handling_total
    end
  end

  prepend OverrideOrderUpdater

end
