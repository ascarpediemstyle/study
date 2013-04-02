class CreateWines < ActiveRecord::Migration
  
  def change
    create_table :wines,{:primary_key => :wine_id} do |t|
      t.string :wine_id
      t.string :wine_name
      t.string :comments
      t.decimal :price

      t.timestamps
    end
    
  end
end