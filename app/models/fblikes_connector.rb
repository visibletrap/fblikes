require 'simplehttp'
require 'active_support'

class FblikesConnector
  def initialize(httpclient=SimepleHttp)
    @httpclient = httpclient
  end
  def fetch(company_ids)
    company_ids.map{ |c| ActiveSupport::JSON.decode(@httpclient.get("http://graph.facebook.com/#{c}")).keep_if{ |key| ['id', 'name', 'likes'].include?(key) } }
  end
end
