class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :yt_hash
      t.integer :sc_id
      t.string :title
      t.boolean :is_fixed
      t.integer :number

      t.timestamps
    end
  end
end
