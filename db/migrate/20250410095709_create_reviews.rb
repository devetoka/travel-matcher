class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :request, null: false, foreign_key: true
      t.references :reviewer, null: false, foreign_key: {to_table: :users}
      t.references :reviewee, null: false, foreign_key: { to_table: :users}
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
