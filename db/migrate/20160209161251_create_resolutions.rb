class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.string :resolution_width
      t.string :resolution_height
    end
  end
end
