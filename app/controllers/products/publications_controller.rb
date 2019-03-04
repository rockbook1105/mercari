class Products::PublicationsController < ApplicationController
  before_action :set_product, only: [:update, :destroy]

  def update
    @product.update(published: true)
    redirect_to root_path, notice: "商品の出品を再開しました"
  end

  def destroy
    @product.update(published: false)
    redirect_to root_path, notice: "商品の出品を停止しました"
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
