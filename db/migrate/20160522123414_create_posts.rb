class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string  :title, null: false
      t.text    :text, null: false
      t.inet    :author_ip, null: false
      t.integer :rate_sum, default: 0
      t.integer :rate_count, default: 0

      t.timestamps null: false
    end
  end
end
