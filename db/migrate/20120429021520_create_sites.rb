class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :url, :null => false
      t.string :title
      t.text :description
      t.belongs_to :user, :null => false

      t.timestamps
    end
  end
end
