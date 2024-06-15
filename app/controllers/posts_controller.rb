class PostsController < ApplicationController
  def index 
    @posts = Post.all
  end
  
  def show
    if params[:id]
      @post = Post.find(params[:id])
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      handle_media_upload(@post)
      redirect_to post_path(@post)
    else
      flash[:error] = @post.error
      render :new
    end
  end

  def edit
    if params[:id]
      @post = Post.find(params[:id])
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      handle_media_upload(@post)
      redirect_to post_path(@post)
    else
      flash[:error] = @post.error
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      delete_post_folder(@post)
      flash[:success] = 'post is successfully deleted'
      redirect_to controller: 'posts', action: :index
    else
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end

  def handle_media_upload(post)
    delete_old_media(post, :image)
    delete_old_media(post, :video)
    upload_file(post, :image)
    upload_file(post, :video)
  end

  def upload_file(post, file_type)
    file = params[:post][file_type]
    return unless file.present?

    folder_path = Rails.root.join("public/assets/post/#{file_type.to_s.pluralize}", post.id.to_s)
    FileUtils.mkdir_p(folder_path) unless Dir.exist?(folder_path)

    tempfile = file.tempfile
    original_filename = file.original_filename
    extension = File.extname(original_filename)
    new_filename = "#{post.id}#{extension}"
    new_path = folder_path.join(new_filename)

    FileUtils.cp(tempfile, new_path)
    post.update("#{file_type}_name": new_filename)
  end

  def delete_old_media(post, file_type)
    old_filename = post.send("#{file_type}_name")
    file = params[:post][file_type]
    return unless old_filename.present? && file.present?

    old_file_path = Rails.root.join("public/assets/post/#{file_type.to_s.pluralize}", post.id.to_s, old_filename)
    File.delete(old_file_path) if File.exist?(old_file_path)
  end

  def delete_post_folder(post)
    image_folder_path = Rails.root.join("public/assets/post/images", post.id.to_s)
    video_folder_path = Rails.root.join("public/assets/post/videos", post.id.to_s)
    FileUtils.rm_rf(image_folder_path) if Dir.exist?(image_folder_path)
    FileUtils.rm_rf(video_folder_path) if Dir.exist?(video_folder_path)
  end
end