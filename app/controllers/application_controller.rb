class ApplicationController < ActionController::Base
  before_action :authenticate
  protect_from_forgery with: :exception
  #protect_from_forgery with: :null_session

  def set_current_user(user_data)
    user_data.password=""
    session[:last_login]=Time.now
  	session[:current_user]=user_data
  end

  def set_current_cafe(cafe)
  	session[:current_cafe]=cafe
  end

  def authenticate
    if !session[:current_user].nil?
      last_login_time=session[:last_login]
      current_time=Time.now
      time_diff=current_time-1800
      if !last_login_time.nil? and time_diff<last_login_time
        session[:last_login]=Time.now
        return true
      else
        @msg="User Time Out. Kindly Login Again!!!"
        @success=false
        session[:current_user]=nil
        session[:last_login]=nil
        respond_to do |format|
        format.js{render :partial=>"users/user_action_redirection.js.erb",:locals=>{:from=>"logout"}}
        format.html{render :template=>'users/welcome.html.erb'}
        end
      end
    else
      @msg="User Time Out. Kindly Login Again!!!"
      @success=false
      respond_to do |format|
        format.js{render :partial=>"users/user_action_redirection.js.erb",:locals=>{:from=>"logout"}}
        format.html{render :template=>'users/welcome.html.erb'}
      end
    end
  end

  def populate_timeline
  	current_cafe=Cafe.find_by_id(session[:current_cafe]["id"].to_i)
  	page=params[:page]
  	all_posts=Post.paginate_by_sql("select * from posts where cafe_id=#{current_cafe.id} and lock_version<>-1 order by id desc",:page=>page,:per_page=>10)
  	blogs_entry=all_posts.collect{|x| x if x.post_type=="Blog"}.compact
  	all_blog_id=blogs_entry.map(&:post_id)
  	if !all_blog_id.empty?
  		blogs=Blog.where("id in (?) and lock_version<>-1",all_blog_id)
  	end
  	@posts=[]
    @comments_count=[]
  	all_posts.each do |post|
  		case post.post_type
  		when "Blog"
  			selected_post=blogs.select{|x| x if x.id==post.post_id}.compact.last
  			@posts<<selected_post
  		end
      @comments_count<<post.get_comments_count
  	end
  end

  def get_members
    current_cafe=Cafe.find_by_id(session[:current_cafe]["id"].to_i)
    page=params[:page].to_i
    @members_data=[]
    if page==1
      per_page=8
      admin_data=User.find_by_id(current_cafe.admin_id)
      @members_data<<admin_data
    else
      per_page=9
    end
   
    all_users=CafeUser.paginate_by_sql("select * from cafe_users where cafe_id=#{current_cafe.id} and lock_version<>-1 ",:page=>page,:per_page=>per_page)
    user_ids=all_users.map(&:user_id)
    member_datas=User.where("id in (?) and lock_version<>-1",user_ids)
    member_datas.each do |user|
      @members_data<<user
    end
  end
end
