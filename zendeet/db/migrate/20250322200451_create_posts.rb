class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :type, null: false
      t.string :origin, null: false
      t.string :destination, null: false
      t.string :date_range
      t.text :description
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end

    add_index :posts, :start_date
    add_index :posts, :end_date
    add_index :posts, :origin
    add_index :posts, :destination
    add_index :posts, :type
    add_index :posts, [:start_date, :end_date, :origin, :destination, :type]
  end
end
