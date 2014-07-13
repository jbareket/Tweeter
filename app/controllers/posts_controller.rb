class PostsController < ApplicationController
  def index
    @posts = Post.all
    #now when we go to index page, it will run activerecord query
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    before_filter authenticate_user! if !current_user
    @post = Post.new
  end

  def edit
    before_filter authenticate_user! if !current_user
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    @post.user_id = current_user.id

    if @post.save
      redirect_to post_path(@post), notice: "Post saved!"
    else
      render 'new'
    end 

  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render 'edit'
    end 
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy
    redirect_to posts_path
  end

  private 
    def post_params
      params.require(:post).permit(:content)
    end
    # hey rails, its ok to update content field in database through our rails application

end

# new view creates a form to make a new item
# form rendered on edit template that calls update
# models are always singular, controllers are plural

