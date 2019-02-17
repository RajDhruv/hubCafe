class BlogsController < ApplicationController
  def new
  	@blog=Blog.new
  	render :partial=>"blogs/blogs_redirection.js.erb", :locals=>{:from=>"new"}
  end

  def create
  	@blog=Blog.new
  	@blog.title=params[:title]
  	@blog.description=params[:blog][:description]
  	@blog.created_at=Time.now
  	@blog.created_by=session[:current_user]["id"]
  	@blog.cafe_id=session[:current_cafe]["id"]
  	if @blog.save
  		@msg="Blog Created Successfully"
  		@success=true
  		populate_timeline
  	else
  		@msg="Error In Blog Creation."
  		@success=false
  	end
  	render :partial=>"blogs/blogs_redirection.js.erb", :locals=>{:from=>"create"}
  end

  def edit
  end

  def update
  end
  
  def show
  end

  def delete
    @blog=Blog.find(params[:id])
    if @blog.delete_blog
      @msg="Blog '#{@blog.title}' Deleted Successfully."
      @success=true
    else
      @msg="Blog '#{@blog.title}' Could Not Be Deleted."
      @success=false
    end
    render :partial=>"blogs/blogs_redirection.js.erb", :locals=>{:from=>"delete"}
  end
end
