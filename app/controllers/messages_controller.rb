class MessagesController < ApplicationController
  def inbox
  	current_user=User.find_by_id(session[:current_user]["id"])
  	all_message_details=Message.where("lock_version<>-1 and (receipient_one=? or receipient_two=?)",current_user.id,current_user.id)
  	receipient_one_data=all_message_details.map(&:receipient_one).uniq-[current_user.id]
	receipient_two_data=all_message_details.map(&:receipient_two).uniq-[current_user.id]  
	receipient_data=receipient_one_data+receipient_two_data
	receipient_data=receipient_data.uniq
	@all_users=User.where("lock_version<>-1 and id in(?)",receipient_data)
	render :partial=>"messages/message_redirection.js.erb",:locals=>{:from=>"show_users"}
  end

  def get_messages
  	current_user=User.find_by_id(session[:current_user]["id"])
  	@user=User.where("lock_version<>-1 and id = ?",params[:user_id]).last
  	params[:page]||=1
  	page=params[:page]
  	@messages=Message.paginate_by_sql("select * from messages where lock_version<>-1 and receipient_one in (#{@user.id},#{current_user.id}) and receipient_two in (#{@user.id},#{current_user.id}) order by id desc",:per_page=>15,:page=>page)
    if !@messages.nil? and !@messages.empty?
      @messages=@messages.reverse
      first_msg=@messages.first
      @old_msg_count=Message.find_by_sql("select count(*) as count from messages where lock_version<>-1 and receipient_one in (#{@user.id},#{current_user.id}) and receipient_two in (#{@user.id},#{current_user.id}) and id<#{first_msg.id}").last.count
    end
  	render :partial=>"messages/message_redirection.js.erb",:locals=>{:from=>"get_messages",:current_user=>current_user}
  end

  def send_messages
  	msg_text=params[:msg_text]
  	to_user=params[:user_id]
  	@new_msg=Message.new
  	@new_msg.receipient_one=to_user
  	@new_msg.receipient_two=session[:current_user]["id"]
  	@new_msg.context=msg_text
  	@new_msg.lock_version=1
  	@new_msg.created_at=Time.now
  	@new_msg.updated_at=Time.now
  	if @new_msg.save
  		@msg="Message sent"
  		@success="true"
  	else
  		@msg="Message Sending Failed"
  		@success="false"
  	end
  	render :partial=>"messages/message_redirection.js.erb",:locals=>{:from=>"send_messages"}
  end

  def get_latest_messages
    current_user=User.find_by_id(session[:current_user]["id"])
    @user=User.where("lock_version<>-1 and id = ?",params[:user_id]).last
    @messages=Message.where("lock_version<>-1 and receipient_one in (#{@user.id},#{current_user.id}) and receipient_two in (#{@user.id},#{current_user.id}) and created_at>'#{params[:after_time]}'")
    render :partial=>"messages/message_redirection.js.erb",:locals=>{:from=>"get_latest_messages",:current_user=>current_user}
  end

  def get_old_messages
    current_user=User.find_by_id(session[:current_user]["id"])
    @user=User.where("lock_version<>-1 and id = ?",params[:user_id]).last
    params[:page]||=1
    page=params[:page]
    @messages=Message.paginate_by_sql("select * from messages where lock_version<>-1 and receipient_one in (#{@user.id},#{current_user.id}) and receipient_two in (#{@user.id},#{current_user.id}) and id<#{params[:before_id]}",:per_page=>15,:page=>page)
    if !@messages.nil? and !@messages.empty?
      first_msg=@messages.first
      @old_msg_count=Message.find_by_sql("select count(*) as count from messages where lock_version<>-1 and receipient_one in (#{@user.id},#{current_user.id}) and receipient_two in (#{@user.id},#{current_user.id}) and id<#{first_msg.id}").last.count
    end
    render :partial=>"messages/message_redirection.js.erb",:locals=>{:from=>"get_old_messages",:current_user=>current_user}
  end

  def delete
  end
end
