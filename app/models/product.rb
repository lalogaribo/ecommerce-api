class Product < ApplicationRecord
  belongs_to :type
  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :orders, through: :placements
  validates :name, presence: true, length: { minimum: 5, maximum: 255 }
  validates :description, presence: true, length: { minimum: 5, maximum: 255 }
  validates :quantity, numericality: { only_integer: true, greater_than: 1 }
  validates :price, numericality: { greater_than: 1 }
  validates :type_id, presence: true
  validates :image, presence: true

  scope :filter_by_product_name, ->(keyword) { where('lower(name) LIKE ?', "%#{keyword.downcase}%") }
  scope :above_or_equal_price, ->(price) { where('price >= ?', price) }
  scope :below_or_equal_price, ->(price) { where('price < ?', price) }
  scope :most_recent_products, -> { order(:created_at) }

  def self.search(params = {})
    products = params[:id].present? ? Product.where(id: params[:id]) : Product.all
    products = products.filter_by_product_name(params[:keyword]) if params[:keyword]
    products = products.above_or_equal_price(params[:min_price].to_f) if params[:min_price]
    products = products.below_or_equal_price(params[:max_price].to_f) if params[:max_price]
    products = products.most_recent_products if params[:recent]

    products
  end
end