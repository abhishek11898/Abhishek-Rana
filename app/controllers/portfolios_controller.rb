class PortfoliosController < ApplicationController
  def index 
    @portfolios = Portfolio.all
  end

  def show
    if params[:id]
      @portfolio = Portfolio.find(params[:id])
    end
  end

  def new
    @work = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    if @portfolio.save
      handle_screenshots_upload(@portfolio)
      redirect_to portfolio_path(@portfolio)
    else
      flash[:error] = @portfolio.error
      render :new
    end
  end

  def edit
    if params[:id]
      @work = Portfolio.find(params[:id])
    end
  end

  def update
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.update(portfolio_params)
      if params[:portfolio][:screenshots]
        delete_old_screenshots(@portfolio)
        handle_screenshots_upload(@portfolio)
      end
      redirect_to portfolio_path(@portfolio)
    else
      flash[:error] = @portfolio.error
      render :edit
    end
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.destroy
      delete_portfolio_folder(@portfolio)
      flash[:success] = 'Portfolio is successfully deleted'
      redirect_to controller: 'portfolios', action: :index
    else
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:title, :description, :technologies_used, :website_link)
  end

  def handle_screenshots_upload(portfolio)
    screenshots = params[:portfolio][:screenshots]
    return unless screenshots.present?

    images_folder_path = Rails.root.join(Portfolio.images_folder_path, portfolio.id.to_s)
    FileUtils.mkdir_p(images_folder_path) unless Dir.exist?(images_folder_path)

    screenshots.each_with_index do |screenshot, index|
      begin
        image_tempfile = screenshot.tempfile
        image_original_filename = screenshot.original_filename
        image_extension = File.extname(image_original_filename)
        image_new_filename = "#{index}#{image_extension}" # Using index for ordering
        image_new_path = images_folder_path.join(image_new_filename)

        FileUtils.cp(image_tempfile, image_new_path)
      rescue => e
        Rails.logger.error "Failed to save screenshot #{image_original_filename}: #{e.message}"
        next
      end
    end
  end

    def delete_old_screenshots(portfolio)
      images_folder_path = Rails.root.join(Portfolio.images_folder_path, portfolio.id.to_s)
      return unless Dir.exist?(images_folder_path)
  
      Dir.foreach(images_folder_path) do |filename|
        file_path = File.join(images_folder_path, filename)
        File.delete(file_path) if File.file?(file_path)
      end
    end

    def delete_portfolio_folder(portfolio)
      images_folder_path = Rails.root.join(Portfolio.images_folder_path, portfolio.id.to_s)
      FileUtils.rm_rf(images_folder_path) if Dir.exist?(images_folder_path)
    end
    

end