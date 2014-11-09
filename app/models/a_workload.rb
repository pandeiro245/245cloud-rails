class AWorkload < ActiveRecord::Base
  self.table_name = "workloads"

  def self.ranking(date = nil)
    date = '2014-09-04'
    next_date = (date.to_date + 1.day).to_s
    users = {}
    
    AWorkload.where(
      "created_at > '#{date} 00:00:00'"
    ).where(
      "created_at <= '#{next_date} 00:00:00'"
    ).each do |w|
      users[w.user_hash] = 0 unless users[w.user_hash]
      users[w.user_hash] += 1
    end
    
    users.to_a.sort{|a, b| b[1] <=> a[1]}.each do |u|
      user = User.find(u[0])
      p u[0]
      p "#{user.attributes['name']}: #{u[1]}回"
    end
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
  end
end

