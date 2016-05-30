class AddUserRefToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :user, index: true, null: false, foreign_key: true
    # add_foreign_key :posts, :users
  end
end
