class CreateAnalyzeResults < ActiveRecord::Migration
  def change
    create_table :analyze_results do |t|
      t.string :id
      t.string :wine_id
      t.string :word
      t.integer :count
      t.string :remarks

      t.timestamps
    end
  end
end
