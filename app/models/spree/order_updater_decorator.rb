Spree::OrderUpdater.class_eval do

  module OverrideOrderUpdater
    def update_adjustment_total
      super
      # DD: updated merely for consistancy (not used in calculations)
      order.handling_total = shipments.sum(:handling_total)
    end
  end

  prepend OverrideOrderUpdater

end
