class Spree::Admin::HandlingFeesController < Spree::Admin::ResourceController
  def index
    redirect_to :action => :edit, id: 1
  end

  def show
    redirect_to :action => :edit, id: 1
  end

  private

  def load_resource
    @handling_fee = Spree::HandlingFee.find_or_create_by_id(1)
    @object = @handling_fee
    @calculators = Rails.application.config.spree.calculators.handling_fees
  end
end