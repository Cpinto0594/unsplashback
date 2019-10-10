Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/photos/search', to: 'images#find_photos'
      get '/photos/random', to: 'images#get_random_photos'
      get '/photos/user_liked_photos', to: 'images#user_liked_photos'
      post '/photos/:photo_id/like', to: 'images#like_photo'
      delete '/photos/:photo_id/like', to: 'images#unlike_photo'
      
    end
  end
end
