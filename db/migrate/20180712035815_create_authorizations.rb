class CreateAuthorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :authorizations do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps null: false
    end

    add_index :authorizations, [:provider, :uid], unique: true
  end
end
