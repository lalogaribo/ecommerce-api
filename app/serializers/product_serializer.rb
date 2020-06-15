class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :quantity, :price, :time_to_make, :image, :user_id
  belongs_to :type
  belongs_to :user
end
