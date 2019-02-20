class PostsController < ApplicationController
  skip_before_action :authenticate, only: [:view_post]
  def view_post
    cafe_slug=params[:cafe_url]
    @cafe=Cafe.where("slug='#{cafe_slug}' and lock_version<>-1").last
    if !@cafe.nil?
      post_url=params[:post]
      if !post_url.nil?
        post_url_content=post_url.split('-')
        post_class=post_url_content[0]
        post_id=post_url_content[-1]
        post_name_scrap=post_url_content[1..-2].join(' ')
        case post_class
        when 'Blog'
          @post=Blog.where("id=#{post_id} and lock_version<>-1").last
          if !@post.nil?
            title_scrap=@post.title.split(' ')[0..7].join(' ')
            if !(post_name_scrap==title_scrap)
              @post=nil
            end
          end
        end
      end
    end
    render :template=>"posts/view_post"
  end
end
