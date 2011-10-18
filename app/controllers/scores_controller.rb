include Spawn

class ScoresController < ApplicationController
  def main
    @companies = Company.all(:order => 'likes desc')
    @last_update = Company.first(:order => 'updated_at desc').updated_at
  end

  def fetch
    FblikesConnector.new.fetch([89763898422, 134934362471, 122944751070862, 129522627076360, 25917702541, 159824760741181, 228466295336, 92473978555, 9971058081, 6928344277, 86862329689, 191921700135, 109106055792335, 132917161986, 143098527028, 152412172588, 6352578678, 117874943378, 33416323994, 100899678727, 96921045375, 98685085344, 113302208700321, 295524826909, 92694629572, 113001545421517, 277464289866, 146105272076446, 157162220997026, 263387758481])
  end

  def init
    fetch.each{ |d| Company.new(d).save! }
    render :text => 'Init Success'
  end

  def update
    fetch.each do |d|
      c = Company.find_by_fb_id(d['fb_id'])
      c.likes = d['likes']
      c.save!
    end
    puts 'Update Success at '+Time.now.to_s
  end

  def man_update
    update
    render :text => 'Manual Update Finish'
  end

  def autoupdate
    spawn(:method => :thread) do
      while true
        update
        sleep 60*60
      end
    end
    render :text => 'Schedule Auto-Update'
  end

end
