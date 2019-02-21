class UserMailer < ApplicationMailer
	default :from=>"dhruv.heroku@gmail.com" 

	def welcome_email(user)
	    @user = user
	    @url  = "http://hubcafe.herokuapp.com"
	    mail(:to => user.email, :subject => "HubCafe Welcomes You #{user.name}")
  	end
end
