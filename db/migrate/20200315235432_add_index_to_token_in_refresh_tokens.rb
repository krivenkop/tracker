class AddIndexToTokenInRefreshTokens < ActiveRecord::Migration[6.0]
  def change
    add_index :refresh_tokens, :token
  end
end
