Spree::Order.class_eval do  
  def create_proposed_shipments
    adjustments.shipping.delete_all
    shipments.destroy_all

    packages = Spree::Stock::Coordinator.new(self).packages
    packages.each do |package|
      new_shipment = package.to_shipment
      shipments << new_shipment
      if new_shipment.stock_location.calculator
        amount = new_shipment.stock_location.calculator.compute(package)
        unless amount == 0
          new_shipment.adjustments.create!({
            source: new_shipment.stock_location,
            adjustable: new_shipment,
            amount: amount,
            order: new_shipment.order,
            label: "Handling"
            })
          end
        end
      end

    shipments
  end
end