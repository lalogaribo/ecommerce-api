class Product < ApplicationRecord
  belongs_to :type
  belongs_to :user
  validates :name, presence: true, length: { minimum: 5, maximum: 255 }
  validates :description, presence: true, length: { minimum: 5, maximum: 255 }
  validates :quantity, numericality: { only_integer: true, greater_than: 1 }
  validates :price, numericality: { greater_than: 1 }
  validates :type_id, presence: true
  validates :image, presence: true
end
