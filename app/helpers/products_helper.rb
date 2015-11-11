module ProductsHelper

  def total_cost(products)
    total = 0
    products.each do |prod|
      total += (prod.price * prod.quantity)
    end
    return total
  end

  def search_index(search_word)
    @products = Product.where(name: "#{search_word}")
  end
end
