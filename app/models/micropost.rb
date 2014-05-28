class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user                     # see listing 10.10

  validates :content, presence: true, length: { maximum: 180 } # listing 10.18
  validates :user_id, presence: true         # listing 10.4

  default_scope order: 'microposts.created_at DESC'   # from 10.14
  # DESC is SQL for 'descending' order from newest to oldest

	def self.from_users_followed_by(user)
		followed_user_ids = "SELECT followed_id FROM relationships
													WHERE follower_id = :user_id"
		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
						user_id: user.id)
	end

end
