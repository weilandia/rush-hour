class CreatesAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :browser
      t.string :platform
    end
  end
end
