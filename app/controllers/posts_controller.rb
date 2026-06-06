class PostsController < ApplicationController
  # your code goes here
  # /posts
  def index
    @posts = Post.all
  end
  
  # /posts/:id
  def show
    @post = Post.find(params[:id])
  end

  # /posts/new
  def new
    @post = Post.new
  end

  # /posts (POST)
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new , status: :unprocessable_entity
    end
  end

  # /posts/:id/edit
  def edit
    @post = Post.find(params[:id])
  end

  # /posts/:id (PATCH/PUT)
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post , notice: 'Post was successfully updated.'
    else
      render :edit , status: :unprocessable_entity
    end
  end

  # /posts/:id (DELETE)
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to @post , notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.expect(post: [:title, :content])
  end
end
