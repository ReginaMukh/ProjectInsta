class AddPictureToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :picture, :string
  end
end
