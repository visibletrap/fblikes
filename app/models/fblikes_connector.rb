require 'simplehttp'
require 'active_support'

class FblikesConnector
  def initialize(httpclient=SimpleHttp)
    @httpclient = httpclient
  end
  def fetch(company_ids)
    company_ids.map do |c| 
      ActiveSupport::JSON.decode(
        @httpclient.get("http://graph.facebook.com/#{c}")
      ).keep_if do |key| 
        ['id', 'name', 'likes'].include?(key)
      end    
    end.each do |s|
      s['fb_id'] = s['id']
      s.delete('id')
    end
  end
end
