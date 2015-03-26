require 'spec_helper'
=begin
describe Spree::Calculator::Shipping::HandlingCharge do
  subject { Spree::Calculator::Shipping::HandlingCharge.new }

  context '#available' do
    it 'should return true when order contains only normal products' do
      subject.available?(order_with_two_normal_products).should be_true
    end

    it 'should return true when order contains normal products and subscription products' do
      subject.available?(order_with_one_normal_product_and_one_subscription).should be_true
    end

    it 'should return false when order contains only subscription products' do
      subject.available?(order_with_two_subscriptions).should be_false
    end
  end

  context '#compute' do
    before :each do
      subject.preferred_per_order_charge = 2.10
      subject.preferred_per_item_charge = 1.35
    end

    it 'should return per_order_charge when the order contains one normal product' do
      subject.compute(order_with_one_normal_product).should == 2.10
    end

    it 'should return per_order_charge + per_item_charge when the order contains two normal products' do
      subject.compute(order_with_two_normal_products).should == 3.45
    end

    it 'should return per_order_charge when order contains one normal product and one subscription product' do
      subject.compute(order_with_one_normal_product_and_one_subscription).should == 2.10
    end

    it 'should return per_order_charge + per_item_charge when order contains two normal product and one subscription product' do
      subject.compute(order_with_two_normal_products_and_one_subscription).should == 3.45
    end

    it 'should return 0 if the order only contains subscriptions' do
      subject.compute(order_with_two_subscriptions).should == 0
    end
  end

  def order_with_one_normal_product
    tsi = Spree::ShippingCategory.find_or_create_by_name!("Items")
    first_product = Spree::Product.create!(name: 'First Product', sku: '', price: 10.00, shipping_category_id: tsi.id)
    order = Spree::Order.create!
    first_line_item = order.line_items.new
    first_line_item.variant = first_product.master
    first_line_item.save!
    order
  end

  def order_with_two_normal_products
    tsi = Spree::ShippingCategory.find_or_create_by_name!("Items")
    first_product = Spree::Product.create!(name: 'First Product', sku: '', price: 10.00, shipping_category_id: tsi.id)
    second_product = Spree::Product.create!(name: 'Second Product', sku: '', price: 10.00, shipping_category_id: tsi.id)
    order = Spree::Order.create!
    first_line_item = order.line_items.new
    first_line_item.variant = first_product.master
    first_line_item.save!
    second_line_item = order.line_items.new
    second_line_item.variant = second_product.master
    second_line_item.save!
    order
  end

  def order_with_one_normal_product_and_one_subscription
    tsi = Spree::ShippingCategory.find_or_create_by_name!("Items")
    subscription = Spree::ShippingCategory.find_or_create_by_name!("Subscriptions")
    first_product = Spree::Product.create!(name: 'First Product', sku: '', price: 10.00, shipping_category_id: tsi.id)
    second_product = Spree::Product.create!(name: 'Second Product', sku: '', price: 10.00, subscription: true, shipping_category_id: subscription.id)
    order = Spree::Order.create!
    first_line_item = order.line_items.new
    first_line_item.variant = first_product.master
    first_line_item.save!
    second_line_item = order.line_items.new
    second_line_item.variant = second_product.master
    second_line_item.save!
    order
  end

  def order_with_two_subscriptions
    tsi = Spree::ShippingCategory.find_or_create_by_name!("Items")
    subscription = Spree::ShippingCategory.find_or_create_by_name!("Subscriptions")
    first_product = Spree::Product.create!(name: 'First Product', sku: '', price: 10.00, subscription: true, shipping_category_id: subscription.id)
    second_product = Spree::Product.create!(name: 'Second Product', sku: '', price: 10.00, subscription: true, shipping_category_id: subscription.id)
    order = Spree::Order.create!
    first_line_item = order.line_items.new
    first_line_item.variant = first_product.master
    first_line_item.save!
    second_line_item = order.line_items.new
    second_line_item.variant = second_product.master
    second_line_item.save!
    order
  end

  def order_with_two_normal_products_and_one_subscription
    tsi = Spree::ShippingCategory.find_or_create_by_name!("Items")
    subscription = Spree::ShippingCategory.find_or_create_by_name!("Subscriptions")
    first_product = Spree::Product.create!(name: 'First Product', sku: '', price: 10.00, shipping_category_id: tsi.id)
    second_product = Spree::Product.create!(name: 'Second Product', sku: '', price: 10.00, shipping_category_id: tsi.id)
    third_product = Spree::Product.create!(name: 'Third Product', sku: '', price: 10.00, subscription: true, shipping_category_id: subscription.id)
    order = Spree::Order.create!
    first_line_item = order.line_items.new
    first_line_item.variant = first_product.master
    first_line_item.save!
    second_line_item = order.line_items.new
    second_line_item.variant = second_product.master
    second_line_item.save!
    third_line_item = order.line_items.new
    third_line_item.variant = third_product.master
    third_line_item.save!
    order
  end
end
=end
