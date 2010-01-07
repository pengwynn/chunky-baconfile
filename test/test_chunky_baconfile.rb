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

    should_eventually "verify credentials" do
      
    end

    should_eventually "create a new folder" do
      
    end
    
    should_eventually "creata a new file" do
      
    end
    
    should_eventually "delete a file or a folder" do
      
    end
    
  end
  
  
end
