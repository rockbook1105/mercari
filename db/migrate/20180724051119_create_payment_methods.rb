class CreatePaymentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_methods do |t|
      t.references :user, foreign_key: true, null: false
      t.string :payjp_customer_id, null: false, unique: true
      t.timestamps
    end
  end
end
