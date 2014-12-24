class User < ParseUser
  fields :workload_total_count
  fields :facebook_id
  fields :facebook_id_str

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
    self.limit(300).each do |user|
      user.facebook_id_str = user.attributes['authData']['facebook']['id']
      # user.name = user.attributes['authData']['facebook']['name']
      user.save
    end
  end
  
  def self.top
    html = ""
    [
      'eAYx93GzJ8',
      'F9dj5tdoKf',
      'IRpFevV39i',
      'UbuuaB5Bi7',
      'O9RJN4ANxi',
      'zxgaoUNv6P',
      'MnZEm4pR0B',
      '6NSxlPVVPP',
      'hqKEEBjBJm',
      '3qIMNlYUMw',
      'f7ol3ZT483',
      '1QV2i4Gi3l',
      'gwmOZPj9dN',
      'TUEUJhmv4q',
      '1FjmHnTTWz'
    ].each do |user_id|
      user = User.find(user_id)
      html += "<img src='#{user.attributes['icon_url']}' style='max-height: 50px;' />"
    end
    return html
  end
end
