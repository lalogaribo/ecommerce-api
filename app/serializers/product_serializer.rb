class ProductSerializer < ActiveModel::Serializer
  attributes :name, :description, :quantity, :price, :time_to_make, :image
  # belongs_to :type
  # belongs_to :user
end
