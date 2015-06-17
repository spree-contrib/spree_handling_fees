Spree::Adjustable::AdjustmentsUpdater.class_eval do

  module OverrideAdjustmentsUpdater
    def update
      super

      handling_total = 0
      handling_total = adjustments.handling.reload.map(&:update!).compact.sum

      adjustable.update_columns(
        handling_total: handling_total,
        adjustment_total: adjustable.adjustment_total + handling_total,
        updated_at: Time.now
      ) unless adjustable.destroyed?
    end
  end

  prepend OverrideAdjustmentsUpdater

end
