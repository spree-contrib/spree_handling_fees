Spree::ItemAdjustments.class_eval do
  define_callbacks :handling_adjustments

  def update_adjustments
    # Promotion adjustments must be applied first, then tax adjustments.
    # This fits the criteria for VAT tax as outlined here:
    # http://www.hmrc.gov.uk/vat/managing/charging/discounts-etc.htm#1
    #
    # It also fits the criteria for sales tax as outlined here:
    # http://www.boe.ca.gov/formspubs/pub113/
    # 
    # Tax adjustments come in not one but *two* exciting flavours:
    # Included & additional

    # Included tax adjustments are those which are included in the price.
    # These ones should not effect the eventual total price.
    #
    # Additional tax adjustments are the opposite, affecting the final total.
    promo_total = 0
    run_callbacks :promo_adjustments do
      promotion_total = adjustments.promotion.reload.map(&:update!).compact.sum
      unless promotion_total == 0
        choose_best_promotion_adjustment
      end
      promo_total = best_promotion_adjustment.try(:amount).to_f
    end

    included_tax_total = 0
    additional_tax_total = 0
    run_callbacks :tax_adjustments do
      included_tax_total = adjustments.tax.is_included.reload.map(&:update!).compact.sum
      additional_tax_total = adjustments.tax.additional.reload.map(&:update!).compact.sum
    end

    handling_total = 0
    run_callbacks :handling_adjustments do
      handling_total = adjustments.handling.reload.map(&:update!).compact.sum
    end

    item.update_columns(
    :promo_total => promo_total,
    :included_tax_total => included_tax_total,
    :additional_tax_total => additional_tax_total,
    :handling_total => handling_total,
    :adjustment_total => promo_total + additional_tax_total + handling_total,
    :updated_at => Time.now,
    )
  end

end
