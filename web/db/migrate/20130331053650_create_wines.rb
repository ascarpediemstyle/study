class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :id
      t.string :wine_name
      t.string :comments
      t.decimal :price

      t.timestamps
    end
  end
end
