class ReduceColumnsOfMusicAndWorkload < ActiveRecord::Migration
  def change
    remove_column :musics, :yt_hash
    remove_column :musics, :sc_id
    remove_column :musics, :number
    add_column :musics, :total_count, :integer
    add_column :musics, :key, :string
    add_column :musics, :user_counts, :string

    remove_column :workloads, :yt_hash
    remove_column :workloads, :sc_id
    remove_column :workloads, :number
    add_column :workloads, :key, :string
    add_column :workloads, :music_id, :integer, {index: true}
  end
end

