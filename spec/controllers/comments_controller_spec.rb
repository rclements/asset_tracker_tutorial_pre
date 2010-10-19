require 'spec_helper'

describe CommentsController do
  describe "#index" do
    let(:client)   { Client.create(:name => "TEST", :status => "Good") }
    let(:project)  { Project.create(:name => "TEST", :client => client) }
    let(:ticket)   { Ticket.create(:name => "TEST", :project => project) }
    let(:user)     { User.create(:first_name => 'n', :last_name => 'f', :middle_initial => 'd', :email => 'n@f.com', :password => 'password')}
    let(:work_unit){ WorkUnit.create(:description => "TEST", :hours => 1, :scheduled_at => Time.now, :ticket => ticket, :user => user) }

    let(:client_comment)   { client.comments.create(:comment => "test") }
    let(:project_comment)  { project.comments.create(:comment => "test") }
    let(:ticket_comment)   { ticket.comments.create(:comment => "test") }
    let(:work_unit_comment){ work_unit.comments.create(:comment => "test") }

    describe "with a client id" do
      it "should return comments" do
        get :index, :client_id => client.id
        response.code.should == "200"
        @controller.instance_variable_get("@comments").include?( client_comment).should be true
      end

      describe "with a project id" do
        it "should return comments" do
          get :index, :client_id => client.id, :project_id => project.id
          response.code.should == "200"
          @controller.instance_variable_get("@comments").include?( project_comment).should be true
        end

        describe "with a ticket id" do
          it "should return comments" do
            get :index, :client_id => client.id, :project_id => project.id, :ticket_id => ticket.id
            response.code.should == "200"
            @controller.instance_variable_get("@comments").include?( ticket_comment).should be true
          end

          describe "with a work unit id" do
            it "should return comments" do
              get :index, :client_id => client.id, :project_id => project.id, :ticket_id => ticket.id, :work_unit_id => work_unit.id
              response.code.should == "200"
              @controller.instance_variable_get("@comments").include?( work_unit_comment).should be true
            end
          end
        end
      end
    end
  end
end
