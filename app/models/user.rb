
class User < ApplicationRecord
	mount_uploader :profile_img, FilesHandlerUploader
end
