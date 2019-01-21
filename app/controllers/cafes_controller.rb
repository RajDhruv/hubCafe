class CafesController < ApplicationController
  def new
    @cafe=Cafe.new
    render :partial=>"cafes/cafe_redirection.js.erb",:locals=>{:from=>"new"}
  end

  def create
    @cafe=Cafe.new
    @cafe.name=params[:name]
    @cafe.description=params[:description]
    @cafe.admin_id=session[:current_user]["id"]
    @cafe.cafe_logo=params[:cafe_logo]
    @cafe.created_at=Time.now
    @cafe.updated_at=Time.now
    if @cafe.save
      @msg="Cafe \"#{@cafe.name}\" Opened Successfully."
      @success=true
    else
      @msg="Cafe \"#{@cafe.name}\" Could not be opened due to some issues. Kindly try again later."
      @success=false
    end
    render :partial=>"cafes/cafe_redirection.js.erb",:locals=>{:from=>"create"}
  end

  def show
    cafe_id=params[:cafe_id]
    params[:page]||=1
    @cafe=Cafe.find_by_id(cafe_id)
    set_current_cafe(@cafe)
    populate_timeline #get all timeline posts array
    get_members
    respond_to do |format|
      format.js{render :partial=>"cafes/cafe_redirection.js.erb",:locals=>{:from=>"show"}}
      format.html{render :partial=>"cafes/cafe_timeline.html.erb"}
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def global_cafes
    user=session[:current_user]
    my_cafe=CafeUser.where("user_id=? and lock_version<>-1",user["id"])
    my_cafe_ids=my_cafe.map(&:cafe_id).uniq
    if my_cafe_ids.empty?
      @all_cafes=Cafe.where("admin_id<>? and lock_version<>-1",user["id"])
    else
      @all_cafes=Cafe.where("admin_id<>? and id not in (?) and lock_version<>-1",user["id"],my_cafe_ids)
    end
    render :partial=>"cafes/cafe_redirection.js.erb",:locals=>{:from=>"global_cafes"}
  end

  def my_cafes
    user=session[:current_user]
    @my_cafe=Cafe.where("admin_id=? and lock_version<>-1",user["id"])
    render :partial=>"cafes/cafe_redirection.js.erb",:locals=>{:from=>"my_cafes"}
  end

  def membership_cafes
    user=session[:current_user]
    @cafeuser=CafeUser.where("user_id=? and lock_version<>-1",user["id"])
    @my_cafe=[]
    if !@cafeuser.empty?
      cafe_id=@cafeuser.map(&:cafe_id)
      @my_cafe=Cafe.where("id in (?) and lock_version<>-1",cafe_id)
    end
    render :partial=>"cafes/cafe_redirection.js.erb",:locals=>{:from=>"membership_cafes"}
  end

  def show_all_members
    get_members
    render :partial=>"cafes/cafe_redirection.js.erb",:locals=>{:from=>"show_all_members"}
  end

  def tasks
    render :partial=>"cafes/cafe_redirection.js.erb",:locals=>{:from=>"tasks"}
  end

end
