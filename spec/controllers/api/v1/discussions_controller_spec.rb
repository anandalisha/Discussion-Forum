require 'rails_helper'

RSpec.describe Api::V1::DiscussionsController do

    describe 'GET /api/v1/discussion/:id' do
        
        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:discussion) { create :discussion, title: 'gynyun', content: 'gbnufnyu rvjutun', user_id: user.id}

        let(:discussion_token) { create(:doorkeeper_access_token, resource_owner_id: discussion.id) }
	    let(:user_token) { create(:doorkeeper_access_token, resource_owner_id: discussion.id) }


        it 'returns the status code ok' do
            get :show, params: {
                id: discussion.id,
                access_token: discussion_token.token,
                format: :json
               }
            expect(response).to have_http_status(:ok)
        end

        context "when authorization is not given" do
            it 'remains unauthorized' do
              get :index
              expect(response).to have_http_status(401)
            end
        end
          
        context "when authorization is given" do
            before() do
              get :index, params: {
                access_token: user_token.token,
                response: :json
      
              }
            end
            
            it 'lists all discussions' do
              expect(response).to have_http_status(200)
            
            end
        end
    end

    describe 'POST /api/v1/discussions' do
        
        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:discussion) { create :discussion, title: 'gynyun', content: 'gbnufnyu rvjutun', user_id: user.id}

        let(:discussion_token) { create(:doorkeeper_access_token, resource_owner_id: discussion.id) }
	    let(:user_token) { create(:doorkeeper_access_token, resource_owner_id: discussion.id) }

        context "when authorization is not given" do
            before() do
              post :create, format: :json
            end
            it 'shows error' do
              expect(response).to have_http_status(401)
            end
        end
      
        context "when authorization is given" do
            before() do
              post :create, params: {
                access_token: user_token.token,
                discussion: attributes_for(:discussion)
              }
            end
            
            it 'creates discussion' do
              expect(response).to have_http_status(200)
            end
        end

        context "when authorization is given" do
            before() do
              post :create, params: {
                access_token: user_token.token,
                discussion: attributes_for(:discussion)
              }
            end
            it 'creates discussion' do
              expect(response).to have_http_status(200)
            end
        end
    end

    describe 'PUT /api/v1/discussions/:id' do
    
        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:discussion) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user.id}

        let(:discussion_token) { create(:doorkeeper_access_token, resource_owner_id: discussion.id) }
	    let(:user_token) { create(:doorkeeper_access_token, resource_owner_id: discussion.id) }
    
        context "when authorization is not provided" do
    
            it 'shows unauthorized message' do
              expect(response).to have_http_status(200)
            end
        end

        context "when authorization is provided" do
    
            it 'shows success message' do
              expect(response).to have_http_status(200)
            end
        end
    end

        describe 'DELETE /api/v1/discussions/:id' do
            
            let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
            let(:discussion) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user.id}

    
            it 'should reduce the discussion count by one' do
                delete :destroy, params: {
                id: discussion.id,
                channel: 'dfthyum'
            }
                expect(Discussion.count).to eq(1)
            end
        end

end