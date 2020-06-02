require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product should be created with valid data" do
    product1 = products(:one)
    product = product1
    assert product.valid?
  end
end
