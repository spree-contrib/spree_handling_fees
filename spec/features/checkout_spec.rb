require 'spec_helper'

describe 'Checkout', js: true do

  let!(:usa) { create(:country, name: "United States of America", states_required: true) }
  let!(:alabama) { create(:state, name: "Alabama", abbr: "AL", country: usa) }
  let!(:washington) { create(:state, name: "Washington", abbr: "WA", country: usa) }

  let!(:handling_calculator) { Spree::Calculator::Shipping::FlexiRate.new(first_item: 1.90, additional_item: 0.40) }
  # default calculator in the Spree factory is flat rate of $10, which is exactly what we want
  let!(:shipping_method) { create(:shipping_method, tax_category_id: 1, calculator: shipping_calculator) }
  let!(:stock_location) { create(:stock_location, country_id: stock_location_address.country.id, state_id: stock_location_address.state.id, address1: stock_location_address.address1, city: stock_location_address.city, zipcode: stock_location_address.zipcode) }
  let!(:mug) { create(:product, name: "RoR Mug", price: 10) }
  let!(:payment_method) { create(:check_payment_method) }
  let!(:zone) { create(:zone) }
  
  let!(:handling_fee) { create(:handling_fee, name: "Handling Fee", stock_location: stock_location, calculator: handling_calculator) }

  before do
    stock_location.stock_items.update_all(count_on_hand: 10)
  end

  it "should calculate and display handling for one item on payment step and allow full checkout" do
    add_to_cart("RoR Mug")
    click_button "Checkout"

    fill_in "order_email", with: "test@example.com"
    click_button "Continue"
    fill_in_address(alabama_address)
    click_button "Save and Continue"
    click_button "Save and Continue"
    page.should have_content("Handling Fee: $1.90")

    click_on "Save and Continue"
    expect(current_path).to match(spree.order_path(Spree::Order.last))
  end

  it "should calculate and display handling for multiple items on payment step and allow full checkout" do
    add_to_cart("RoR Mug")
    add_to_cart("RoR Mug")
    add_to_cart("RoR Mug")
    click_button "Checkout"

    fill_in "order_email", with: "test@example.com"
    click_button "Continue"
    fill_in_address(alabama_address)
    click_button "Save and Continue"
    click_button "Save and Continue"
    page.should have_content("Handling Fee: $2.70")

    click_on "Save and Continue"
    expect(current_path).to match(spree.order_path(Spree::Order.last))
  end

  it 'should update the handling fee when cart contents change' do
    add_to_cart("RoR Mug")
    click_button "Checkout"

    fill_in "order_email", with: "test@example.com"
    click_button "Continue"
    fill_in_address(alabama_address)
    click_button "Save and Continue"
    click_button "Save and Continue"
    page.should have_content("Handling Fee: $1.90")
    
    add_to_cart("RoR Mug")
    click_button "Checkout"    
    page.should have_content("Handling Fee: $2.30")
  end
  
  def add_to_cart(item_name)
    visit spree.products_path
    click_link item_name
    click_button "add-to-cart-button"
  end

  def fill_in_address(address)
    fieldname = "order_bill_address_attributes"
    fill_in "#{fieldname}_firstname", with: address.first_name
    fill_in "#{fieldname}_lastname", with: address.last_name
    fill_in "#{fieldname}_address1", with: address.address1
    fill_in "#{fieldname}_city", with: address.city
    select address.country.name, from: "#{fieldname}_country_id"
    select address.state.name, from: "#{fieldname}_state_id"
    fill_in "#{fieldname}_zipcode", with: address.zipcode
    fill_in "#{fieldname}_phone", with: address.phone
  end
  
  def stock_location_address
    stock_location_address = Spree::Address.new(
    firstname: "Testing",
    lastname: "Location",
    address1: "3121 W Government Way",
    city: "Seattle",
    country: Spree::Country.where(name: "United States of America").first,
    state: Spree::State.where(abbr: "WA").first,
    zipcode: "98199-1402",
    phone: "(555) 5555-555")
  end
  
  def alabama_address
    alabama_address = Spree::Address.new(
    firstname: "John",
    lastname: "Doe",
    address1: "143 Swan Street",
    city: "Montgomery",
    country: Spree::Country.where(name: "United States of America").first,
    state: Spree::State.where(name: "Alabama").first,
    zipcode: "36110",
    phone: "(555) 5555-555")
  end
  
end
