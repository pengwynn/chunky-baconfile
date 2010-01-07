module ChunkyBaconfile
  class Client
    attr_accessor :username
    include HTTParty
    format :json
    base_uri "http://baconfile.com"

    # Intialize the client
    #
    # @param [optional, String] username your Baconfile username
    # @param [optional, String] password your Baconfile password
    # @return the client
    def initialize(username=nil, password=nil)
      @username = username
      @auth = {:username => username, :password => password}
    end

    # Fetch the files in a folder
    #
    # @param [String] folder_name the name of the folder
    # @return [Array<FileInfo>] the items in the folder
    def folder(folder_name)
      response = self.class.get("/#{@username}/#{folder_name}.json")
      response['items'].map {|item| ChunkyBaconfile::FileInfo.new(item)}
    end

    # Fetch info about an item
    #
    # @param [String] folder_name the name of the folder
    # @param [String] file_name the name of the file
    # @return [FileInfo] the items in the folder
    def file(folder_name, file_name)
      ChunkyBaconfile::FileInfo.new(self.class.get("/#{@username}/#{folder_name}/#{file_name}.json"))
    end
    
    # Fetch the latest public files
    #
    # @return [Array<FileInfo>] returns last 20 most recent public files
    def public
      response = self.class.get("/public.json")
      response['items'].map {|item| ChunkyBaconfile::FileInfo.new(item)}
    end
    
    # Create a new folder
    #
    # @param [String] folder_name the name of the folder to create
    # @return [FileInfo] info about the new folder
    def create_folder(folder_name)
      ChunkyBaconfile::FileInfo.new(self.class.post("/#{@username}.json", :body => {:name => folder_name}, :basic_auth => @auth))
    end
    
    # Upload a new file
    #
    # @param [String, File] path or file object to upload
    # @return [FileInfo] info about the new folder
    def upload_file(file)
      file = File.new(file) if file.is_a?(String)
      body_options = {:file => file}
      opts = build_multipart_bodies(body_options).merge({:basic_auth => @auth})
      ChunkyBaconfile::FileInfo.new(self.class.post("/#{@username}.json", opts))
    end
    
    # Delete a folder or file
    #
    # @param [String] name the folder or file to delete
    # @return [Hashie::Mash] :success or :error 
    def delete(name)
      response = Hashie::Mash.new(self.class.delete("/#{username}/#{name}.json", :basic_auth => @auth))
    end
    
    # Verify credentials
    #
    # @return [true, false] whether or not the credentials are a match
    def verify
      response = Hashie::Mash.new(self.class.get("/verify.json", :basic_auth => @auth))
      response.key?(:user)
    end
    
    # Return the MIME type for a file
    #
    # @param [File] file
    # @return [String] mime type for the file
    def mime_type(file)
      case 
        when file =~ /\.jpg/ then 'image/jpg'
        when file =~ /\.gif$/ then 'image/gif'
        when file =~ /\.png$/ then 'image/png'
        else 'application/octet-stream'
      end
    end
    
  
    # Build multi-part POST form data from file
    #
    # @param [Hash] parts keys/values of items to convert for upload
    # @return [Hash] encoded form data for POST
    def build_multipart_bodies(parts)
      boundary = Time.now.to_i.to_s(16)
      body = ""
      parts.each do |key, value|
        esc_key = CGI.escape(key.to_s)
        body << "--#{boundary}#{"\r\n"}"
        if value.respond_to?(:read)
          body << "Content-Disposition: form-data; name=\"#{esc_key}\"; filename=\"#{File.basename(value.path)}\"#{"\r\n"}"
          body << "Content-Type: #{mime_type(value.path)}#{"\r\n"*2}"
          body << value.read
        else
          body << "Content-Disposition: form-data; name=\"#{esc_key}\"#{"\r\n"*2}#{value}"
        end
        body << "\r\n"
      end
      body << "--#{boundary}--#{"\r\n"*2}"
      {
        :body => body,
        :headers => {"Content-Type" => "multipart/form-data; boundary=#{boundary}"}
      }
    end


  end
end
