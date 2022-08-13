class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', autosave: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_post_counter
  before_destroy :update_posts_down

  validates :title, presence: true, allow_blank: false, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def update_post_counter
    author.increment!(:posts_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).includes([:author]).limit(5)
  end

  def update_posts_down
    author.update_columns('posts_counter' => author.posts_counter - 1)
  end
end
