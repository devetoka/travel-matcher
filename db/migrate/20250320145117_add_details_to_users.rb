class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string, default: ""
    add_index :users, :username, unique: true
    add_column :users, :location, :string
    add_column :users, :phone_number, :string
    add_column :users, :preferred_contact_method, :string, default: "email"
    add_column :users, :bio, :text
    add_column :users, :verified, :boolean, default: false
  end
end
