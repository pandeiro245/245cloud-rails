class Music < ParseResource::Base
  fields :key, :title, :is_fixed, :userCounts
  
  def self.sync
    AWorkload.where(
      is_done: true
    ).each do |workload|
      music = Music.find_or_create_by(
        key: workload.key
      )
      music.userObjects = {
        
      }
    end
  end
end

