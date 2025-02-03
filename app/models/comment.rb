class Comment < Activity
  validates :content, presence: true
end
