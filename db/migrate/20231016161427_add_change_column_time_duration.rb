class AddChangeColumnTimeDuration < ActiveRecord::Migration[7.0]
  def change
    remove_column :lectures, :time_duration
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    add_column :lectures, :time_duration, :integer
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
