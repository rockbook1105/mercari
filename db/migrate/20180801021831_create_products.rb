class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, index: true, null: false
      t.text :detail, null: false
      t.integer :shipping_fee_charges_on, null: false
      t.integer :deliverable_days, null: false
      t.integer :price, null: false
      t.references :user, null: false
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
