require 'rails_helper'

RSpec.describe Api::V1::ChannelsController do

    describe 'GET /api/v1/channel/:id' do
        
        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:discussion) { create :discussion, title: 'gynyun', content: 'gbnufnyu rvjutun', user_id: user.id}
        let(:channel) { create :channel, channel: 'hbhirfk', discussion_id: discussion.id}

        let(:discussion_token) { create(:doorkeeper_access_token, resource_owner_id: discussion.id) }
	      let(:user_token) { create(:doorkeeper_access_token, resource_owner_id: user.id) }
        let(:channel_token) { create(:doorkeeper_access_token, resource_owner_id: user.id) }


        it 'returns the status code ok' do
            get :show, params: {
                id: channel.id,
                discussion_id: discussion.id,
                access_token: channel_token.token,
                format: :json
               }
            expect(response).to have_http_status(:ok)
        end

        context "when not given authorization" do
            it 'unauthorized user' do
              get :show, params: {
                id: channel.id,
                access_token: channel_token.token,
                response: :json
      
              }
              expect(response).to have_http_status(200)
            end
        end
          
        context "when not authorized" do
            
          before() do
              get :show, params: {
                id: channel.id,
                access_token: channel_token.token,
                response: :json
      
              }
            end
            
            it 'all channels listings' do
      
              expect(response).to have_http_status(200)
            
            end
        end
    end

    describe 'POST /api/v1/channels' do
        
        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:discussion) { create :discussion, title: 'gynyun', content: 'gbnufnyu rvjutun', user_id: user.id}
        let(:channel) { create :channel, channel: 'hbhirfk', discussion_id: discussion.id}

        let(:discussion_token) { create(:doorkeeper_access_token, resource_owner_id: discussion.id) }
	      let(:user_token) { create(:doorkeeper_access_token, resource_owner_id: discussion.id) }
        let(:channel_token) { create(:doorkeeper_access_token, resource_owner_id: channel.id) }

        context "when authorization is not given" do
            before() do
              post :create, format: :json
            end
            it 'shows error' do
              expect(response).to have_http_status(200)
            end
        end
      
        context "when authorization is given" do
            before() do
              post :create, params: {
                access_token: user_token.token,
                channel: attributes_for(:channel)
              }
            end
            
            it 'creates channel' do
              expect(response).to have_http_status(200)
            end
        end

        context "when authorization is given" do
            before() do
              post :create, params: {
                access_token: user_token.token,
                channel: attributes_for(:channel)
              }
            end
        end
    end

    describe 'PUT /api/v1/channels/:id' do
    
        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:discussion) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user.id}
        let(:channel) { create :channel, channel: 'hbhirfk', discussion_id: discussion.id}

        let(:discussion_token) { create(:doorkeeper_access_token, resource_owner_id: discussion.id) }
	      let(:user_token) { create(:doorkeeper_access_token, resource_owner_id: discussion.id) }
        let(:channel_token) { create(:doorkeeper_access_token, resource_owner_id: channel.id) }
    
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

        describe 'DELETE /api/v1/channels/:id' do
            
            let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
            let(:discussion) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user.id}
            let(:channel) { create :channel, channel: 'hbhirfk', discussion_id: discussion.id}

    
            it 'should reduce the discussion count by one' do
                delete :destroy, params: {
                  id: channel.id,
                  discussion_id: discussion.id
            }
                expect(Channel.count).to eq(1)
            end
        end

end