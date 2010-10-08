require 'spec_helper'
include Devise::TestHelpers

describe AdminBaseController do

  describe "GET 'index'" do

    describe "for non-admin users" do
      it "should deny access" do
        get :index
        response_should redirect_to(root_path)
        flash[:error].should =~ /admin/i
      end
    end
  end
end
