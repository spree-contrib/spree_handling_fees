Spree::Shipment.class_eval do
  # Override in super-hacky way the has_one from Spree 2.0
  # Revisit this solution to making it dependent: destroy on Shipments
  # in Spree 2.1 and Spree 2.2
  has_many :adjustments, as: :source, dependent: :destroy
end