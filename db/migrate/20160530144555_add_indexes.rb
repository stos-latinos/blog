class AddIndexes < ActiveRecord::Migration
  def change
    add_index :posts, [:rate_count, :rate_sum]
    add_index :posts, :author_ip
  end
end
