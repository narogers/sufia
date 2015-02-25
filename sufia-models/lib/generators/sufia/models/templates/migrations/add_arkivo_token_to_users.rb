class AddArkivoTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :arkivo_token, :string
  end
end
