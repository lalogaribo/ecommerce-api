class TypeSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :products
end
