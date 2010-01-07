module ChunkyBaconfile
  class Client
    attr_accessor :username
    include HTTParty
    format :json
    base_uri "http://baconfile.com"


    def initialize(username, password=nil)
      @username = username
      @auth = {:username => username, :password => password}
    end

    def folder(folder_name)
      response = self.class.get("/#{@username}/#{folder_name}.json")
      response['items'].map {|item| ChunkyBaconfile::FileInfo.new(item)}
    end

    def file(folder_name, file_name)
      ChunkyBaconfile::FileInfo.new(self.class.get("/#{@username}/#{folder_name}/#{file_name}"))
    end
    
    def public
      response = self.class.get("/public.json")
      response['items'].map {|item| ChunkyBaconfile::FileInfo.new(item)}
    end
    
    def create_folder(folder_name)
      ChunkyBaconfile::FileInfo.new(self.class.post("/#{@username}.json", :body => {:name => folder_name}, :basic_auth => @auth))
    end
    
    def upload_file(file)
      file = File.new(file) if file.is_a?(String)
      body_options = {:file => file}
      opts = build_multipart_bodies(body_options).merge({:basic_auth => @auth})
      ChunkyBaconfile::FileInfo.new(self.class.post("/#{@username}.json", opts))
    end
    
    def delete(name)
      response = Hashie::Mash.new(self.class.delete("/#{username}/#{name}.json", :basic_auth => @auth))
    end
    
    def verify
      response = Hashie::Mash.new(self.class.get("/verify.json", :basic_auth => @auth))
      response.key?(:user)
    end
    
    def self.mime_type(file)
      case 
        when file =~ /\.jpg/ then 'image/jpg'
        when file =~ /\.gif$/ then 'image/gif'
        when file =~ /\.png$/ then 'image/png'
        else 'application/octet-stream'
      end
    end
    def mime_type(f) self.class.mime_type(f) end
  
    CRLF = "\r\n"
    def self.build_multipart_bodies(parts)
      boundary = Time.now.to_i.to_s(16)
      body = ""
      parts.each do |key, value|
        esc_key = CGI.escape(key.to_s)
        body << "--#{boundary}#{CRLF}"
        if value.respond_to?(:read)
          body << "Content-Disposition: form-data; name=\"#{esc_key}\"; filename=\"#{File.basename(value.path)}\"#{CRLF}"
          body << "Content-Type: #{mime_type(value.path)}#{CRLF*2}"
          body << value.read
        else
          body << "Content-Disposition: form-data; name=\"#{esc_key}\"#{CRLF*2}#{value}"
        end
        body << CRLF
      end
      body << "--#{boundary}--#{CRLF*2}"
      {
        :body => body,
        :headers => {"Content-Type" => "multipart/form-data; boundary=#{boundary}"}
      }
    end
    
    def build_multipart_bodies(parts) self.class.build_multipart_bodies(parts) end

  end
end
