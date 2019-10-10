require_relative '../../app/services/images_services'

class ImagesControllerTest < ActiveSupport::TestCase
    Service_instance = ImagesServices.INSTANCE


    test "should return only 10 random images" do
        photos = Service_instance.request_random_photos 10
        assert photos != nil && photos.size() == 10, "Returns only 10 random photos successfully"
    end

    test "should return only 10 car images" do
        photos = Service_instance.request_search_photos "car"
        photos = photos["results"]
        assert photos != nil && photos.size() == 10, "Returns only 10 random photos successfully"
    end

    test "should like images by real id" do
        photos = Service_instance.request_user_like_photo "ZtAfAm2LfGc"
        photos = photos["photo"] 
        assert photos != nil && photos["liked_by_user"] == true , "Successfully liked photo"
    end

    test "should fail like images by non existing id" do
        photos = Service_instance.request_user_like_photo "ZtAfAmLfGc"
        photos = photos["error"] 
        assert_not photos == nil  , "Failed to like photo by non existing id"
    end

end