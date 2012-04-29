class AddHeadingAndIntroductionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :heading, :string
    add_column :users, :introduction, :text
  end
end
