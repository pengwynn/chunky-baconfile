require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'fakeweb'
gem 'jnunemaker-matchy', '0.4.0'
require 'matchy'

FakeWeb.allow_net_connect = false

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'chunky_baconfile'

class Test::Unit::TestCase
end

def baconfile_url(url)
  url =~ /^http/ ? url : "http://baconfile.com#{url}"
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def stub_get(url, filename, options={})
  opts = {:body => fixture_file(filename)}.merge(options)
  
  FakeWeb.register_uri(:get, baconfile_url(url), opts)
end