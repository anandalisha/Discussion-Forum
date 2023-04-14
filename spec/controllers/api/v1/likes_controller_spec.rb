require 'rails_helper'

RSpec.describe Api::V1::LikesController do

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

    
        describe 'DELETE /api/v1/likes/:id' do
            
            let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
            let(:discussion) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user.id}
            let(:like) { create :like, user_id: user.id, likeable_id: discussion.id, likeable_type: 'Discussion'}

    
            it 'should reduce the like count by one' do
                delete :destroy, params: {
                    id: like.id,
                    user_id: user.id,
                    likeable_type: 'Discussion'
            }
                expect(Like.count).to eq(0)
            end
        end

end