class CreatePortfoliosTable < ActiveRecord::Migration[5.2]
  def up
    create_table :portfolios do |t|
      t.string :title
      t.text :description
      t.string :technologies_used
      t.string :image_folder
      t.string :website_link

      t.timestamps
    end
  end

  def down 
    drop_table :portfolios
  end
end