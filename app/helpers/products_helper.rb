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

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def any_information(product)
    info = product.description ? product.description : 'No product information, to add click on the product name and edit the description'
    return info
  end
end
