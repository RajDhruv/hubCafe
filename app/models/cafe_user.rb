class CafeUser < ApplicationRecord
	has_one :invitation, foreign_key: 'id'
	after_create :soft_delete_invitation

	def soft_delete_invitation
		update_query="Update invitations set lock_version=-1 where id=#{self.from_invitation}"
		ActiveRecord::Base.connection.execute(update_query)
	end

end