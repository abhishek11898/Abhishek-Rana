class CreatePostsTable < ActiveRecord::Migration[5.2]
  def up
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :image_name
      t.string :video_name

      t.timestamps
    end
  end

  def down 
    drop_table :posts
  end
end