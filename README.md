# chunky-baconfile

Tasty wrapper for the [Baconfile API](http://baconfile.com/api). [Baconfile](http://baconfile.com) is a handy way to share, comment, and tweet about files uploaded to your [Amazon S3](https://s3.amazonaws.com/) account.

## Installation

    sudo gem install chunky_baconfile
    
## Usage

    # crank up a client object
    >> client = ChunkyBaconfile::Client.new('username', 'password')
    
    # create a folder
    >> client.folder('test_folder')
    => <#ChunkyBaconfile::FileInfo content_type="image/png" description="" file_url="http://s3.amazonaws.com:80/pengwynn.baconfile.com/test_folder%2Fwynn-120x120.png" id="3c05b1e667fc3cf4fd6219d146324bdd" is_folder=false name="wynn-120x120.png" path="pengwynn/test_folder/wynn-120x120.png" permalink="http://baconfile.com/pengwynn/test_folder/wynn-120x120.png/" size=7271 time_modified=1262755171 tiny_url="http://tinyb.cn/1qm" type="image" url="/pengwynn/">>
    
    # get a list of files in a folder
    >> client.folder('test_folder')
    => [<#ChunkyBaconfile::FileInfo content_type="image/png" description="" file_url="http://s3.amazonaws.com:80/pengwynn.baconfile.com/test_folder%2Fwynn-120x120.png" id="3c05b1e667fc3cf4fd6219d146324bdd" is_folder=false name="wynn-120x120.png" path="pengwynn/test_folder/wynn-120x120.png" permalink="http://baconfile.com/pengwynn/test_folder/wynn-120x120.png/" size=7271 time_modified=1262755171 tiny_url="http://tinyb.cn/1qm" type="image" url="/pengwynn/test_folder/wynn-120x120.png/" user=<#Hashie::Mash id=947 timezone="America/Chicago" username="pengwynn">>]
    
    # get info about a single item
    >> client.file('test_folder', 'wynn-120x120.png')
    => <#ChunkyBaconfile::FileInfo content_type="image/png" description="" file_url="http://s3.amazonaws.com:80/pengwynn.baconfile.com/test_folder%2Fwynn-120x120.png" id="3c05b1e667fc3cf4fd6219d146324bdd" is_folder=false name="wynn-120x120.png" path="pengwynn/test_folder/wynn-120x120.png" permalink="http://baconfile.com/pengwynn/test_folder/wynn-120x120.png/" size=7271 time_modified=1262755171 tiny_url="http://tinyb.cn/1qm" type="image" url="/pengwynn/test_folder/wynn-120x120.png/" user=<#Hashie::Mash id=947 timezone="America/Chicago" username="pengwynn">>

    # upload a file
    >> client.upload_file('cat.jpg')
    => <#ChunkyBaconfile::FileInfo content_type="image/jpg" description="" file_url="http://s3.amazonaws.com:80/pengwynn.baconfile.com/cat.jpg" id="763e5559987f22aa710fdbd3bac0fc40" is_folder=false name="cat.jpg" path="pengwynn/cat.jpg" permalink="http://baconfile.com/pengwynn/cat.jpg/" size=39368 time_modified=1262884937 tiny_url="http://tinyb.cn/1qz" type="image" url="/pengwynn/cat.jpg/" user=<#Hashie::Mash id=947 timezone="America/Chicago" username="pengwynn">>
    
    # Get the most recent public files
    >> ChunkyBaconfile.public
    

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
   bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 [Wynn Netherland](http://wynnnetherland.com). See LICENSE for details.
