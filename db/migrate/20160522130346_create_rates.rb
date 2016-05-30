class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.belongs_to :post, null: false
      t.integer    :value, null: false
    end
  end
end
