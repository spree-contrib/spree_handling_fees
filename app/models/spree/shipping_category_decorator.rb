Spree::ShippingCategory.class_eval do
  has_many :handling_fees, class_name: "Spree::HandlingFee"
end