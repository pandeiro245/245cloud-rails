class Room < ParseResource::Base
  fields :name, :comments_count
  def self.update_comments_count sec
    while(true)
      Room.limit(1000000).each do |room|
        count = Comment.limit(10000000).where(room_id: room.id).length
        room.comments_count = count
        puts "count is #{count}"
        room.save
      end
      sleep sec
    end
  end
end
