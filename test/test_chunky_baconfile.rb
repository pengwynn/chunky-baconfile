require 'helper'

class TestChunkyBaconfile < Test::Unit::TestCase
  context "when unauthenticated" do
    
    setup do
      @bacon = ChunkyBaconfile::Client.new("leah")
    end

    should "return items in a folder" do
      stub_get("http://baconfile.com/leah/bacon.json", "bacon.json")
      items = @bacon.folder("bacon")
      items.size.should == 12
      items.first.size.should == 84295
      items.first.path.should == 'leah/bacon/bacon-comic.gif'
      items.first.user.username.should == 'leah'
    end
    
    should "return info about a file" do
      stub_get("http://baconfile.com/leah/bacon/cat.jpg.json", "cat.jpg.json")
      file = @bacon.file("bacon", "cat.jpg.json")
      file.size.should == 39368
      file.permalink.should == "http://baconfile.com/leah/cat.jpg/"
      file.description.should == "die in a fire!"
      file.time_modified.should == Time.at(1236391578)
    end
    
    should "return a list of most recent public files" do
      stub_get("http://baconfile.com/public.json", "public.json")
      items = @bacon.public
      items.size.should == 20
      items.first.size.should == 54462
      items.first.description.should == 'GPS on Lake Tahoe'
      items.first.user.username.should == 'pengwynn'
    end
  end
  
  context "when authenticated" do
    
    setup do
      @bacon = ChunkyBaconfile::Client.new("pengwynn", "test")
    end

    should_eventually "verify credentials" do
      
    end

    should "create a new folder" do
      stub_post("http://pengwynn:test@baconfile.com/pengwynn.json", "new_folder.json")
      folder = @bacon.create_folder("test_folder")
      folder.url.should == '/pengwynn/test_folder/'
      folder.time_modified.should == Time.at(1262753640)
      folder.size.should be_nil
    end
    
    should "creata a new file" do
      stub_post("http://pengwynn:test@baconfile.com/pengwynn.json", "new_file.json")
      file = @bacon.upload_file(File.new(binary_file_fixture('cat.jpg')))
      file.tiny_url.should == 'http://tinyb.cn/1qm'
      file.time_modified.should == Time.at(1262755171)
      file.size.should == 7271
    end
    
    should_eventually "delete a file or a folder" do
      
    end
    
  end
  
  
end
