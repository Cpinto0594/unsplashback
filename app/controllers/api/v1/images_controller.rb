require_relative '../../../services/images_services'
  

class Api::V1::ImagesController < ApplicationController
    
    Service_instance = ImagesServices.INSTANCE

    def index 
        output = {'foo' => 'bar'}
        render :json => output

    end

    def find_photos
     
        obj_return = {}
        obj_return["success"]=true

        search_word = params["query"] || query;
       
        
        begin           
            
            result = (Service_instance.request_search_photos search_word )
            if ( result["results"] != nil )
                obj_return["photos"] = 
                result["results"]
                .map{|photo| 
                    Service_instance.parse_photo photo
                }
            end
            
        rescue => exception
            puts exception
            obj_return["success"]=false
            obj_return["message"]="Could not load images #{exception.message}"
        end

        render :json => obj_return, :status => 200
    end 

    def get_random_photos 
        count    = params[:count] || 50
        obj_return = {}
        obj_return["success"]=true
        
        begin           
            obj_return["photos"] = 
            ( Service_instance.request_random_photos count)
            .map{|photo| 
                Service_instance.parse_photo photo
             }

        rescue => exception
            puts exception
            obj_return["success"]=false
            obj_return["message"]="Could not load random images #{exception.message}"
        end

        render :json => obj_return, :status => 200
    end     

    
    def like_photo
        obj_return = {}
        obj_return["success"]=true
        

        photo_id = params["photo_id"]
        
        
        begin           
            photo = ( Service_instance.request_user_like_photo photo_id )
            if photo != nil
                photo = Service_instance.parse_photo photo["photo"]
            end

            obj_return["photos"] = photo
            rescue => exception
            puts exception
            obj_return["success"]=false
            obj_return["message"]="Could not like photo #{exception.message}"
        end

        render :json => obj_return, :status => 200
    end 
 
    def unlike_photo
        obj_return = {}
        obj_return["success"]=true
        

        photo_id = params["photo_id"]
        
        
        begin           
            photo = ( Service_instance.request_user_unlike_photo photo_id )
            if photo != nil
                photo = Service_instance.parse_photo photo["photo"]
            end

            obj_return["photos"] = photo
            rescue => exception
            puts exception
            obj_return["success"]=false
            obj_return["message"]="Could not unlike photo #{exception.message}"
        end

        render :json => obj_return, :status => 200
    end 

     
    def user_liked_photos
        obj_return = {}
        obj_return["success"]=true
        
        begin           
            obj_return["photos"] = 
            Service_instance.request_user_likes
            .map{|photo| 
                Service_instance.parse_photo photo
             }

        rescue => exception
            puts exception
            obj_return["success"]=false
            obj_return["message"]="Could not load user favs images #{exception.message}"
        end

        render :json => obj_return, :status => 200
    end 



   

end
