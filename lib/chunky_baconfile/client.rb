module ChunkyBaconfile
  class Client
    attr_accessor :username
    include HTTParty
    format :json
    base_uri "http://baconfile.com"


    def initialize(username)
      @username = username
    end

    def folder(folder_name)
      response = self.class.get("/#{username}/#{folder_name}.json")
      response['items'].map {|item| ChunkyBaconfile::FileInfo.new(item)}
    end

    def file(folder_name, file_name)
      ChunkyBaconfile::FileInfo.new(self.class.get("/#{username}/#{folder_name}/#{file_name}"))
    end
    
    def public
      response = self.class.get("/public.json")
      response['items'].map {|item| ChunkyBaconfile::FileInfo.new(item)}
    end

  end
end
