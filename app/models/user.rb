class User < ParseUser
  def workload_count date
    #TODO
    Workload.where(created_at: date.to_date).where(is_done: true).count
  end
end
