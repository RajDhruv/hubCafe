class UsersController < ApplicationController
	# skip_before_filter :verify_authenticity_token, :only => [:create]
  def welcome

  end
  
  def register
  	@user=User.new
  	render :partial=>"user_action_redirection.js.erb", :locals=>{:from=>"register"}
  end

  def create
  	exist_email=User.where("email=?",params[:email]).last
	if exist_email.nil?
		@user=User.new
    @user.name = params[:name]
    @user.age = params[:age]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.sex = params[:sex]
    @user.date_of_birth = params[:date_of_birth]
    @user.profile_def = params[:profile_def]
    @user.profile_img = params[:profile_img]
		@user.created_at=Time.now
		if @user.save
			@msg="Welcome to HubCafe #{@user.name}"
			@success=true
		else
			@msg="Sorry #{params[:name]}: There seems to be some error. Kindly try after some time."
			@success=false
		end
	else
	  	@msg="Sorry #{params[:name]}: Email you entered is already registered with us. Kindly register with another Email ID."
		@success=false
	end
  	render :partial=>"user_action_redirection.js.erb", :locals=>{:from=>"userCreate"}
  end
 

  def login
  	render :partial=>"user_action_redirection.js.erb", :locals=>{:from=>"login"}
  end

  def validate_login
  	@user_data=User.where("email=?",params[:email]).last
  	if @user_data.nil?
  		@msg="User with Email #{params[:email]} is not a member of HubCafe yet!"
		@success=false
  	else
  		if @user_data.password==params[:password]
  			set_current_user(@user_data)
  			@success=true
  		else
  			@msg="#{@user_data.name} you have entered wrong password to enter the Cafe."
			@success=false
  		end
  	end
  	render :partial=>"user_action_redirection.js.erb", :locals=>{:from=>"validateLogin"}
  end

  def logout
  	session[:current_user]=nil
  	#render :template=>"users/welcome.html.erb"
  	render :partial=>"user_action_redirection.js.erb", :locals=>{:from=>"logout"}
  end

  def edit
  end

  def delete
  end

end