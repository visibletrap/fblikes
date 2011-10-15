require 'spec_helper'

describe ScoresController do

  describe "get list of likes" do
    it "get scores" do
      companies = [ mock_model(Company) ]
      Company.should_receive(:all).and_return(companies)
      get :main
      assigns[:companies].should eq(companies)
    end
  end

  describe "get init" do
    it "should call FblikesConnector and pass company ids" do
      company_ids = [89763898422, 134934362471, 122944751070862, 129522627076360, 25917702541, 159824760741181, 228466295336, 92473978555, 9971058081, 6928344277, 86862329689, 191921700135, 109106055792335, 132917161986, 143098527028, 152412172588, 6352578678, 117874943378, 33416323994, 100899678727, 96921045375, 98685085344, 113302208700321, 295524826909, 92694629572, 113001545421517, 277464289866, 146105272076446, 157162220997026, 263387758481]
      FblikesConnector.any_instance.should_receive(:fetch).with(company_ids).and_return([])
      get :init
    end
    it "should insert results from FblikesConnector to Company" do
      data = [
        { "fb_id" => "1", "name" => "aa", "likes" => 12 },
        { "fb_id" => "2", "name" => "bb", "likes" => 34 }
      ]
      fb = FblikesConnector.any_instance.stub(:fetch).and_return(data)
      company = mock_model(Company)
      Company.should_receive(:new).with(data[0]).and_return(company)
      company.should_receive(:save!)
      
      company2 = mock_model(Company)
      Company.should_receive(:new).with(data[1]).and_return(company2)
      company2.should_receive(:save!)

      get :init
    end
  end

  describe "get update" do
    it "should call FblikesConnector and pass company ids" do
      company_ids = [89763898422, 134934362471, 122944751070862, 129522627076360, 25917702541, 159824760741181, 228466295336, 92473978555, 9971058081, 6928344277, 86862329689, 191921700135, 109106055792335, 132917161986, 143098527028, 152412172588, 6352578678, 117874943378, 33416323994, 100899678727, 96921045375, 98685085344, 113302208700321, 295524826909, 92694629572, 113001545421517, 277464289866, 146105272076446, 157162220997026, 263387758481]
      FblikesConnector.any_instance.should_receive(:fetch).with(company_ids).and_return([])
      get :update
    end
    it "should update likes of matching company that has the same fb_id" do
      data = [
        { "fb_id" => "1", "name" => "aa", "likes" => 12 },
        { "fb_id" => "2", "name" => "bb", "likes" => 34 }
      ]
      fb = FblikesConnector.any_instance.stub(:fetch).and_return(data)

      company = mock_model(Company)
      Company.should_receive(:find_by_fb_id).with("1").and_return(company)
      company.should_receive(:likes=).with(12)
      company.should_receive(:save!)

      company2 = mock_model(Company)
      Company.should_receive(:find_by_fb_id).with("2").and_return(company2)
      company2.should_receive(:likes=).with(34)
      company2.should_receive(:save!)

      get :update
    end
  end

end
