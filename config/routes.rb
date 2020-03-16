Rails.application.routes.draw do
  devise_for :users,
             path: '',
             skip: [:sessions, :registration],
             defaults: { format: :json }
  as :user do
    post "/login" => "users/sessions#create", :as => :user_session
    post "/update-access-token" => "users/sessions#update_access_token", :as => :update_access_token
    delete "/logout" => "users/sessions#destroy", :as => :destroy_user_session
    post "/signup" => "users/registrations#create"
  end


  root to: 'static#home'
  get '*path' => 'static#home'
end
