Spree::Order.class_eval do

  def display_handling_total
    Spree::Money.new(handling_total, { currency: currency })
  end

  # Creates a adjustments representing handling charges, if applicable.
  # Following 'create_tax_charge!' convention.
  def create_handling_charge!
    shipments.each do |shipment|
      if shipment.stock_location.calculator
        amount = shipment.stock_location.calculator.compute_shipment(shipment)
        unless amount == 0
          shipment.adjustments.create!({
            source: shipment.stock_location,
            adjustable: shipment,
            amount: amount,
            order: shipment.order,
            label: "Handling"
          })
        end
      end
    end
  end

  module OverrideCreateProposedShipments
    def create_proposed_shipments
      shipments = super

      create_handling_charge!

      shipments
    end
  end

  prepend OverrideCreateProposedShipments

end
