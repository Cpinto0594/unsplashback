class ImagesServices

    @@INSTANCE = self.new
    def self.INSTANCE
         @@INSTANCE
    end

    SearchPhotos_Uri        = "https://api.unsplash.com/search/photos?page=1&per_page=10"
    Random_Uri              = "https://api.unsplash.com/photos/random?count=IMAGES_COUNT"
    UserLikes_Uri           = "https://api.unsplash.com/users/cpinto0594/likes"
    UserLikePhoto_Uri       = "https://api.unsplash.com/photos/PHOTO_ID/like"
    ### private methods

    def parse_photo photo
        if photo == nil 
            return nil
        end
        photo_table = photo
        photo_user  = photo_table["user"] ||{}
        photo_urls  = photo_table["urls"].slice("full", "regular")

        {
            id:photo_table["id"],
            create_at:photo_table["created_at"],
            width:photo_table["width"],
            height:photo_table["height"],
            color:photo_table["color"],
            description:photo_table["description"],
            liked_by_user:photo_table["liked_by_user"],
            alt:photo_table["alt_description"],
            urls:photo_urls,
            likes:photo_table["likes"],
            user:photo_user["username"],
        }
    end

    def request_search_photos ( search_word )
        uri = URI.parse(SearchPhotos_Uri + "&query=#{search_word}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(uri.request_uri)
        request["Authorization"] = "Bearer 2d6f241bf54cf7ea7dfa49ff70cf1daa123f4a0319f9b9012d06a057919ed914"
        response = http.request(request)
        return JSON.parse response.body
    end

    def request_random_photos count
            uri = URI.parse(( Random_Uri.gsub 'IMAGES_COUNT', count.to_s ))
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true

            request = Net::HTTP::Get.new(uri.request_uri)
            request["Authorization"] = "Bearer 2d6f241bf54cf7ea7dfa49ff70cf1daa123f4a0319f9b9012d06a057919ed914"
            response = http.request(request)
            return JSON.parse response.body
    end

    def request_user_likes
        uri = URI.parse(UserLikes_Uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(uri.request_uri)
        request["Authorization"] = "Bearer 2d6f241bf54cf7ea7dfa49ff70cf1daa123f4a0319f9b9012d06a057919ed914"
        response = http.request(request)
        
        return JSON.parse response.body
    end

    def request_user_like_photo id
        _url = ( UserLikePhoto_Uri.gsub "PHOTO_ID" , id )
        uri = URI.parse(_url)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Post.new(uri.request_uri)
        request["Authorization"] = "Bearer 2d6f241bf54cf7ea7dfa49ff70cf1daa123f4a0319f9b9012d06a057919ed914"
        response = http.request(request)
        return JSON.parse response.body
    end

    def request_user_unlike_photo id
        _url = ( UserLikePhoto_Uri.gsub "PHOTO_ID" , id )
        uri = URI.parse(_url)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Delete.new(uri.request_uri)
        request["Authorization"] = "Bearer 2d6f241bf54cf7ea7dfa49ff70cf1daa123f4a0319f9b9012d06a057919ed914"
        response = http.request(request)
        return JSON.parse response.body
    end


end