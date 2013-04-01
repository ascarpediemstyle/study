class CreateAnlyzeResults < ActiveRecord::Migration
  def up
    create_table :analyze_results do |t|
      t.string :id
      t.string :wine_id
      t.string :word
      t.string :remarks
      t.integer :count

      t.timestamps
    end
  end

  def down
  end
end
