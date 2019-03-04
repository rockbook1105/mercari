class Products::PurchaseController < ApplicationController
  before_action :set_product, only: [:new, :create]
  before_action :redirect_to_root, if: :already_purchased?

  def new; end

  def create
    charge = PayjpService.charge!(@product, current_user)

    if !charge["error"]
      ActiveRecord::Base.transaction  do
        current_user.purchase_histories.create!(
          product_id: @product.id,
          payjp_charge_id: charge["id"]
        )
        @product.update!(purchased: true)
      end

      redirect_to root_path, notice: "#{@product.name}を購入しました"
    else
      render :new, alert: "決済に失敗しました。詳細はカード会社に問い合わせください。"
    end
  end

  private

  def already_purchased?
    @product.purchased?
  end

  def redirect_to_root
    redirect_to root_path, alert: '既に売り切れた商品です'
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
