class AWorkload < ActiveRecord::Base
  self.table_name = "workloads"

  def self.ranking(date = nil)
    users = {}
    html = "<h1>Dailyランキング（11/◯◯、◯曜日）</h1>"
    limit = 10

    if date
      limit = 20
      next_date = (date.to_date + 1.day).to_s
      cond = "created_at > '#{date} 00:00:00' and created_at <= '#{next_date} 00:00:00'"
    else
      cond = ""
    end
    
    AWorkload.where(
      cond
    ).each do |w|
      users[w.user_hash] = 0 unless users[w.user_hash]
      users[w.user_hash] += 1
    end
  
    i = 0
    users.to_a.sort{|a, b| b[1] <=> a[1]}.each do |u|
      next if i > limit #FIXME
      user = User.find(u[0])
      p "#{user.attributes['name']} #{user.attributes['objectId']}:#{u[1]}"
      html += "<img src='#{user.attributes['icon_url']}' style='max-height: 50px;' />: #{u[1]}回　"
      i += 1
    end
    return html
  end

  def self.sync!
    Workload.limit(10000000).where(is_done: true).each do |w|
      begin
        a = AWorkload.find_or_create_by(
          user_hash: w.attributes['user']['objectId'],
          created_at: w.attributes['createdAt']
        )
        a.is_done    = w.attributes['is_done']
        a.updated_at = w.attributes['updatedAt']
        a.save
      rescue
      end
    end
    'done'
  end
end

