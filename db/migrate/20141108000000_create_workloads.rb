class CreateWorkloads < ActiveRecord::Migration
  def change
    create_table :workloads do |t|
      t.string :yt_hash
      t.integer :sc_id
      t.string :title
      t.boolean :is_done
      t.integer :number
      t.string :user_hash
    
      t.timestamps
    end
  end
end
