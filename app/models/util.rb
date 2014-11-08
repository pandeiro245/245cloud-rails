class Util
  
  def self.sync!
    #self.sync_music!
    
    Workload.limit(10000000).where(is_done: true).map{|w| w.attributes['sc_id'].to_i > 0 ? "soundcloud:#{w.attributes['sc_id'].to_i.to_s}" : "youtube:#{w.attributes['yt_id']}"}.uniq.each do |key|
      service = key.split(':').first
      id =  key.split(':').last
      puts "id is #{id}"
      if service == 'soundcloud'
        if Music.where(sc_id: id).blank?
          puts "save soundcloud: #{key}"
        else
          puts "not save soundcloud: #{key}"
          raise
        end
      elsif service == 'youtube' && key != 'youtube:'
        if Music.where(yt_id: id).blank?
          puts "save youtube: #{key}"
        else
          puts "not save youtube: #{key}"
        end
      end
    end
  end
  
  def sync_music!
    Music.all.each do |music|
      client_id = '2b9312964a1619d99082a76ad2d6d8c6'
      client = Soundcloud.new(:client_id => client_id)
      track = client.get("/tracks/#{music.sc_id}")
      music.title = track.title
      music.is_fixed = true
      music.save
    end
  end
  
  # https://github.com/soundcloud/soundcloud-ruby
  # https://developers.soundcloud.com/docs/api/reference#tracks
  def self.soundcloud
    client_id = '2b9312964a1619d99082a76ad2d6d8c6'
    client = Soundcloud.new(:client_id => client_id)
    tracks = client.get('/tracks', :limit => 10, :order => 'hotness')
    tracks.each do |track|
      puts track.permalink_url
    end
  end
end