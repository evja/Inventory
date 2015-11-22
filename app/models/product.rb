class Product < ActiveRecord::Base
  validates :name, :admin_id, :price, presence: true

  # default_scope -> { order(name: :asc) }

  belongs_to :admin, dependent: :destroy

  def self.search(query, user)
    # where(:name => query)
    q = query.capitalize
    user.products.where("name like ?",  "%#{q}%")
  end

  def self.import(file, user)
    if file && user
      CSV.foreach(file.path, headers: true) do |row|

        product_hash = row.to_hash
        product = user.products.where(id: product_hash["id"])

        if product.count == 1
          product.first.update_attributes(product_hash)
        else
          user.products.create!(product_hash)
        end # end if !product.nil?
      end # end CSV.foreach
      return true
    else
      return false
    end
  end # end self.import(file)
end
