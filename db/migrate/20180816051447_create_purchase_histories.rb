class CreatePurchaseHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_histories do |t|
      t.references :purchaser, null: false
      t.references :product, foreign_key: true, null: false
      t.string :payjp_charge_id, null: false
      t.timestamps
    end
    add_foreign_key :purchase_histories, :users, column: :purchaser_id
  end
end
