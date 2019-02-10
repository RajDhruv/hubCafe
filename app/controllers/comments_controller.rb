class CommentsController < ApplicationController
  def new

  end

  def create
    post=Post.where('post_id=? and post_type=? and lock_version<>-1',params[:post_id],params[:post_class]).last
    @comment=Comment.new
    @comment.description=params[:comm_desc]
    @comment.post_id=post.id
    @comment.created_by=session[:current_user]["id"]
    @comment.lock_version=1
    @comment.save
    @new_comm_count=post.get_comments_count
    render :partial=>"comments/comments_redirection.js.erb",:locals=>{:from=>"create",:post_id=>params[:post_id],:post_class=>params[:post_class]}
  end

  def edit
  end

  def update
  end

  def delete
  end

  def show
    post_id=params[:post_id]
    params[:page]||=1
    page=params[:page]
    post=Post.where('post_id=? and post_type=? and lock_version<>-1',params[:post_id],params[:post_class]).last
    @comments=Comment.paginate_by_sql("Select * from comments where post_id=#{post.id} and lock_version<>-1 order by id desc",:page=>page,:per_page=>10)
    @comments=@comments.reverse
    render :partial=>"comments/comments_redirection.js.erb",:locals=>{:from=>"show",:post_id=>params[:post_id],:post_class=>params[:post_class]}
  end

end
