require 'spec_helper'
include Devise::TestHelpers

describe AdminBaseController do
  before(:each) do
    @user = User.new(first_name: 'Testman',
                    last_name:  'Testman',
                    middle_initial: 'T',
                    email: 'test@example.com')
  end


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
