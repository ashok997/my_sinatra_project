class CreateProductsTable < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.integer :price
      t.string :link  
      t.integer :user_id
  end
end
