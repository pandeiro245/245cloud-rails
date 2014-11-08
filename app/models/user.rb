class User < ParseUser
  fields :workload_total_count
  fields :facebook_id

  def self.refresh!
    User.all.each{|u| u.update_workload_count}
  end

  def update_workload_count
    self.workload_total_count = self.workload_count
    self.save
  end

  def workload_count
    Workload.where(is_done: true, user: self).count
  end

  def best_music
    Workload.limit(10000).where(user: self, is_done: true).map{|w| w.attributes['sc_id'].to_i > 0 ? "soundcloud:#{w.attributes['sc_id'].to_i.to_s}" : "youtube:#{w.attributes['yt_id']}"}.group_by(&:to_s).map(&:first)
  end
  
  def self.sync_auth_data
    self.all.each do |user|
      user.facebook_id = user.attributes['authData']['facebook']['id'].to_i
      # user.name = user.attributes['authData']['facebook']['id']
      user.save
    end
  end
end
