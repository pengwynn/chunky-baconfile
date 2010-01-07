require 'rubygems'
require 'cgi'

gem 'hashie', '~> 0.1.3'
require 'hashie'

gem 'httparty', '~> 0.4.5'
require 'httparty'

module ChunkyBaconfile
  
  # Fetch the latest public files
  #
  # @return [Array<FileInfo>] returns last 20 most recent public files
  def self.public
    ChunkyBaconfile::Client.new.public
  end
end

Hash.send :include, Hashie::HashExtensions

directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, 'chunky_baconfile', 'file_info')
require File.join(directory, 'chunky_baconfile', 'client')