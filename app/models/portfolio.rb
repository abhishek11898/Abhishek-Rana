class Portfolio < ApplicationRecord
  validates :technologies_used, presence: :true

  def self.images_folder_path
    folder_path = Rails.root.join('public', 'assets', 'portfolio', 'images')
    FileUtils.mkdir_p(folder_path) unless Dir.exist?(folder_path)
    folder_path
  end

  def self.images_folder_relative_path
    folder_path = Rails.root.join('app', 'assets', 'portfolio', 'images')
    FileUtils.mkdir_p(folder_path) unless Dir.exist?(folder_path)
    '/assets/portfolio/images'
  end
  

end