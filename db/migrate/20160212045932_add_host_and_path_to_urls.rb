class AddHostAndPathToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :host, :string
    add_column :urls, :relative_path, :string
  end
end
