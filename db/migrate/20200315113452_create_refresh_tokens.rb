class CreateRefreshTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :refresh_tokens do |t|
      t.string :token, null: false
      t.datetime :expires_on, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
