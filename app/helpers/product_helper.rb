module ProductHelper
  def render_item_btns(product)
    if !(@product.user == current_user)
      render 'item_btns'
    end
  end

  def render_publish_status_btns(product)
    if @product.user == current_user
      render partial: 'publish_status_btns', locals: { product: product }
    end
  end
end