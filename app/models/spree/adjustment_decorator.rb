Spree::Adjustment.class_eval do
  scope :handling, -> { where(source_type: 'Spree::HandlingFee') }
end