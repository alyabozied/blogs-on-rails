class BlogPostsController < ApplicationController
    before_action :authenticate_user!, except: [:index,:show]
    before_action :set_blog_post , only: [:show,:edit,:update,:destroy]
    def index
        if user_signed_in?
            @blog_posts = BlogPost.sorted
        else 
            @blog_posts = BlogPost.published.sorted
        end
    end 
    def show 
        
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end     
    def new
        @blog_post = BlogPost.new
    end
    def create
        @blog_post = BlogPost.new(blog_post_params)
        if @blog_post.save
            redirect_to @blog_post
        else 
            render :new , status: :unprocessable_entity
        end
    end 
    def edit
        rescue ActiveRecord::RecordNotFound
            redirect_to root_path
        render :new
    end
    def update
        if @blog_post.update(blog_post_params)
            redirect_to @blog_post
        else
            render :edit , status: :unprocessable_entity
        end
    end
    def destroy
        
        @blog_post.destroy
        redirect_to root_path
    end
    private 
    def blog_post_params
        params.require(:blog_post).permit(:title,:body,:published_at)
    end
    def set_blog_post
        if user_signed_in? 
            @blog_post = BlogPost.find(params[:id])
        else 
            @blog_post = BlogPost.published.find(params[:id])
        end
    end
    
end
