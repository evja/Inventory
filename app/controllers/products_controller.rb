class ProductsController < ApplicationController
  before_action :authenticate_admin!

  before_action :set_admin
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  def index
    if params[:search]
      @products = @admin.products.search(params[:search], @admin).order('created_at DESC').paginate(:page => params[:page], :per_page => 25)
    else
      @products = @admin.products.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 25)
    end
  end

  def import
    if Product.import(params[:file], current_admin)
      redirect_to root_url, notice: "Products imported."
    else
      flash[:notice] = "Oops something went wrong with the download"
      redirect_to settings_path
    end
  end

  def show
  end

  def new
    @product = @admin.products.build
  end

  def create
    @product = @admin.products.build(product_params)
    if @product.save
      redirect_to admin_products_path(@admin)
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @product.update_attributes(product_params)
      redirect_to admin_products_path(current_admin)
    else
      render :edit
    end
  end

  def destroy
    @product.delete

    redirect_to admin_products_path(current_admin)
  end

  private

    def set_admin
      @admin = current_admin
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:admin_id, :name, :size, :quantity, :price, :description, :sort)
    end

    def sort_column
      Product.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

end
