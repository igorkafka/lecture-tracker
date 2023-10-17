class AlterColumnTimeScheduled < ActiveRecord::Migration[7.0]
  def up
    change_column :lectures, :time_scheduled, :datetime, :null => false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
  def down 
    change_column :lectures, :time_scheduled, :date, :null => false
  end
end