class AddShippingFromToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :shipping_from, :string, null: false
  end
end
