class Post < ApplicationRecord
	belongs_to :user, class_name: 'User', foreign_key: 'created_by'
	has_many :comments

	def get_comments_count
		comm_count=Comment.find_by_sql("select count(*) as count from comments where post_id=#{self.id} and lock_version<>-1").last.count
		comm_count
	end
end
