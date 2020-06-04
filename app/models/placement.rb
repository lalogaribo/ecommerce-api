class Placement < ApplicationRecord
  after_create :decrement_quantity
  belongs_to :order
  belongs_to :product, inverse_of: :placements

  def decrement_quantity
    product.decrement!(quantity: quantity)
  end
end
