require 'rails_helper'

feature 'Login page' do
  given(:user) { create(:user) }
  given(:url) { '/login' }
  given(:params) do
    {
        user: {
            email: user.email,
            password: user.password
        }
    }
  end

  context 'When params are correct' do
    background do
      visit url, params: params
    end

    scenario 'redirects to home'
  end

  context 'When login params are incorrect' do
    background { visit url }

    scenario 'shows "Invalid credentials error"'
  end
end