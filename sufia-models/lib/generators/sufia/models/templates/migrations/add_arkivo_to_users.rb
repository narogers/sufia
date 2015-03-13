class AddArkivoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :arkivo_token, :string
    add_column :users, :zotero_request_token, :string
    add_column :users, :zotero_access_token, :string
    add_column :users, :zotero_userid, :string
  end
end
