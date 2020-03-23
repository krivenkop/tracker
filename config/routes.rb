Rails.application.routes.draw do
  devise_for :users,
             path: '',
             skip: [:sessions, :registration],
             defaults: { format: :json }
  as :user do
    post "/login" => "users/sessions#create", :as => :user_session
    post "/update-access-token" => "users/sessions#update_access_token", :as => :update_access_token
    delete "/logout" => "users/sessions#destroy", :as => :destroy_user_session
    post "/verify-access-token" => "users/sessions#verify_access_token", :as => :verify_access_token
    post "/signup" => "users/registrations#create"
  end


  root to: 'static#home'

  namespace :api do
    namespace :v1 do
      constraints(slug: /[a-z0-9]+(?:_[a-z0-9]+)*_\d{10}/) do
        resources :projects, except: [:new, :edit], param: :slug
      end
    end
  end

  get '*path' => 'static#home'
end
