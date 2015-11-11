class Product < ActiveRecord::Base
  validates :name, :size, :price, presence: true

end
