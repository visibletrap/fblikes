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
end
