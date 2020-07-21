class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.string :shop_name, null: false
      t.string :image
      t.string :date
      t.string :price
      t.string :review
      t.integer :rating
      t.string :electrical_outlet
      t.string :wifi
      t.string :url
      t.time :open_time
      t.time :end_time
      t.string :phone_number
      t.string :address
      t.string :smoking_seat
      t.float :latitude
      t.float :longitude
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps
    end
  end
end
