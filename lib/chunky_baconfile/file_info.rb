module ChunkyBaconfile
  class FileInfo < Hashie::Mash
    def size
      self[:size]
    end
    
    def time_modified
      Time.at(self[:time_modified])
    end
  end
end