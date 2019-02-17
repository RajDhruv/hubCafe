class PostsController < ApplicationController
  
  def view_post
    case params[:type]
    when 'Blog'
      @post=Blog.where("id=#{params[:id]} and lock_version<>-1").last
    end
    render :template=>"posts/view_post"
  end
end
