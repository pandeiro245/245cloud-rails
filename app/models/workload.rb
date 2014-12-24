class Workload < ParseResource::Base
  fields :user, :is_done, :sc_id, :yt_id, :mc_id, :et_id, :title, :synchro_start, :synchro_end

  def self.update_synchro_all
    Workload.where(
      is_done: true,
      synchro_start: nil
    ).each do |workload|
      workload.update_synchros
    end
  end

  def update_synchros
    self.synchro_start = self.synchro_start_count
    self.synchro_end = self.synchro_end_count
    self.save
  end

  def synchro_start_count
    #cond = "created_at > '#{self.createdAt.to_s}' and created_at <= '#{self.createdAt}'"
  end

  def get_key
    if self.sc_id
      res = "soundcloud:#{sc_id.to_s}"
    elsif self.yt_id
      res = "youtube:#{yt_id.to_s}"
    elsif self.mc_id
      res = "mixcloud:#{mc_id.to_s}"
    elsif self.et_id
      res = "8tracks:#{et_id.to_s}"
    else
      res = 'nomusic'
    end
    return res
  end
end

