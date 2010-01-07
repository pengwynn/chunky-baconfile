module ChunkyBaconfile
  class FileInfo < Hashie::Mash
    def size
      self[:size]
    end
  end
end