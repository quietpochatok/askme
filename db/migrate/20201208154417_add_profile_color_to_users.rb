class AddProfileColorToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profile_color, :string, default: '#fc0fc0'
  end
end
