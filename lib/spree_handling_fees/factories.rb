FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.

  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_handling_fees/factories'
end


# helpful: http://benjamintan.io/blog/2014/07/05/overriding-factorygirls-attributes/
FactoryGirl.modify do

  # stock location now requires a calculator during testing
  factory :stock_location do
    association(:calculator, factory: :shipping_calculator, strategy: :build)
  end

end
