require 'helper'

class TestChunkyBaconfile < Test::Unit::TestCase
  context "when unauthenticated" do
    
    setup do
      @bacon = ChunkyBaconfile.new("leah")
    end

    should "return items in a folder" do
      stub_get("http://baconfile.com/leah/bacon.json", "bacon.json")
      items = @bacon.folder("bacon")
      items.size.should == 11
      items.first.size.should == 84295
      items.first.user.username.should == 'leah'
    end
    
    should_eventually "return info about a file" do
      
    end
    
    should_eventually "return a list of most recent public files" do
      
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
