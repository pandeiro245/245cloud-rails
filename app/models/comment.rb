class Comment < ParseResource::Base
  fields :body, :user

  validates_presence_of :body
end

