class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all #仮データ表示のため
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = current_user.products.new
    4.times { @product.images.build }
  end

  def create
    binding.pry
    @product = current_user.products.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @images = @product.images
    (4 - @images.length).times { @product.images.build }
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to root_path
    else
      # implement something here
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :deliverable_days,
      :detail,
      :name,
      :price,
      :shipping_fee_charges_on,
      :shipping_from,
      :shipping_method,
      :status,
      images_attributes: [:id, :image, :_destroy]
    )
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
