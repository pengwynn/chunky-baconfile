module ChunkyBaconfile
  class Client
    attr_accessor :username
    include HTTParty
    format :json


    def initialize(username)
      @username = username
      self.class.base_uri("http://baconfile.com/#{username}")
    end

    def folder(folder_name)
      response = self.class.get("/#{folder_name}.json")
      response['items'].map {|item| ChunkyBaconfile::FileInfo.new(item)}
    end

    def file(folder_name, file_name)
      ChunkyBaconfile::FileInfo.new(self.class.get("/#{folder_name}/#{file_name}"))
    end

  end
end
