require 'spec_helper'
require 'simplehttp'

describe FblikesConnector do
  describe "#fetch" do
    it "should do http request to get company informations from Facebook" do
      http = mock(SimpleHttp)
      fblikes = FblikesConnector.new(http)

      http.should_receive(:get).with("http://graph.facebook.com/1").and_return('{}')
      http.should_receive(:get).with("http://graph.facebook.com/2").and_return('{}')

      fblikes.fetch([1,2])
    end

    it "should return result as hash of id, name, likes" do
      http = mock(SimpleHttp)
      fblikes = FblikesConnector.new(http)
      
      http.stub(:get).with("http://graph.facebook.com/1")
        .and_return('{ "id":"98685085344",
                       "name":"Channel 8",
                       "likes":104390,
                       "category":"Tv channel" }')

      fblikes.fetch([1]).should == [{ "id" => "98685085344",
                                      "name" => "Channel 8", 
                                      "likes" => 104390 }]
    end
  end
end
