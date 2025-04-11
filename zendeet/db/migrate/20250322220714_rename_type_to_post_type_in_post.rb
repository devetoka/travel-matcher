class RenameTypeToPostTypeInPost < ActiveRecord::Migration[7.1]
  def change
    rename_column :posts, :type, :post_type
  end
end
