Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
                 registration: 'signup'
             },
             :skip => [:sessions, :registration]
  as :user do
    post "/signin" => "users/sessions#create", :as => :user_session
    delete "/logout" => "users/sessions#destroy", :as => :destroy_user_session
    post "/signup" => "users/registrations#create"
  end


  root to: 'application#index'
  get '*path' => 'application#index'
end
