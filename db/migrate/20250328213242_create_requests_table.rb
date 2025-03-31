class CreateRequestsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.references :post, null: false, foreign_key: true
      t.references :requester, null: false, foreign_key: { to_table: :users }
      t.text :description, default: nil
      t.string :status, null: false, default: "pending"
      t.string :milestone, default: nil

      t.timestamps
    end

    add_index :requests, [:post_id, :requester_id], unique: true
    add_index :requests, [:status]
  end
end
