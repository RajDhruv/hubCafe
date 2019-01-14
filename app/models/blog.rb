class Blog < ApplicationRecord

	after_create :create_post
	belongs_to :user, class_name: 'User', foreign_key: 'created_by'

	def create_post
		@post=Post.new
		@post.title=self.title
		@post.description=self.description
		@post.cafe_id=self.cafe_id
		@post.post_id=self.id
		@post.post_type=self.class.name
		@post.created_by=self.created_by
		@post.save
	end
end
