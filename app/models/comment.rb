class Comment < ApplicationRecord
	belongs_to :post, class_name: 'Post', foreign_key: 'post_id'
	belongs_to :user, class_name: 'User', foreign_key: 'created_by'

	def soft_delete
		sql="Update comments set lock_version=-1,updated_at=now() where id=#{self.id}"
		ActiveRecord::Base.connection.execute(sql)
	end
end
