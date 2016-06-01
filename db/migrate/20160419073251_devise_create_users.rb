class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## user config
      t.string    :nickname,     null: false, default: ""
      t.string    :first_name,     null: false, default: ""
      t.string    :middle_name,    default: ""
      t.string    :last_name,      null: false, default: ""
      t.integer   :role

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      t.string :users, :provider
      t.string :users, :uid
      t.string :users, :token
      t.string :users, :name
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :nickname,             unique: true
    add_index :users, :reset_password_token, unique: true

  end
end
