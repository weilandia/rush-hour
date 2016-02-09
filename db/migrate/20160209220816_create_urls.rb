class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :path
    end
  end
end
