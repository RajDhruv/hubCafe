class Cafe < ApplicationRecord
	self.table_name = "cafes"
	after_create :update_cafe_slug

	def update_cafe_slug
		name=self.name
		trunc_name=name.downcase.gsub(" ","_")
		random_num=rand(10000)
		slug=trunc_name+"_"+self.id.to_s+"_"+random_num.to_s
		self.update_attribute(:slug,slug)
	end
end