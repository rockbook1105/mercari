class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :family_name, null: false
      t.string :first_name, null: false
      t.string :family_name_kana, null: false
      t.string :first_name_kana, null: false
      t.string :zipcode, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :block_number, null: false
      t.string :building_name
      t.string :phone_number
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
