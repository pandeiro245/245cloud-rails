class AMusic < ActiveRecord::Base
  def self.sync!
    res = {}
    html = ""
    Workload.limit(10000000).where(is_done: true).each do |w|
      if w.attributes['sc_id']
        key = "soundcloud:#{w.attributes['sc_id']}"
      elsif w.attributes['yt_id']
        key = "youtube:#{w.attributes['yt_id']}"
      else # 無音
        next
      end
      res[key] = {number: 0, title: w.attributes['title']}  unless res[key]
      res[key][:number] += 1
    end
    ranking = res.to_a.sort{|a, b| b[1][:number] <=> a[1][:number]}
    0.upto(49).each do |i|
      html += (i + 1).to_s
      html += "位：<a href='#"
      html += ranking[i][0]
      html += "' class='fixed_start'>"
      html += ranking[i][1][:title]
      html += '</a>'
      html += '('
      html += ranking[i][1][:number].to_s
      html += '回)'
      html += '<br />'
    end
    return html
  end
end

