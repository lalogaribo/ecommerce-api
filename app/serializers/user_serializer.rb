class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone_number,
             :is_admin, :address, :zip_code
  has_many :products
end
