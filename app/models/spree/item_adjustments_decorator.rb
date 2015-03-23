Spree::ItemAdjustments.class_eval do
  define_callbacks :handling_adjustments

  module OverrideUpdateAdjustments
    def update_adjustments
      super

      handling_total = 0
      run_callbacks :handling_adjustments do
        handling_total = adjustments.handling.reload.map(&:update!).compact.sum
      end

      item.update_columns(
        :handling_total => handling_total,
        :adjustment_total => item.adjustment_total + handling_total,
        :updated_at => Time.now
      )
    end
  end

  prepend OverrideUpdateAdjustments

end
