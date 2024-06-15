class Post < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  def self.images_folder_path
    "public/assets/post/images"
  end

  def self.videos_folder_path
    "public/assets/post/videos"
  end
end