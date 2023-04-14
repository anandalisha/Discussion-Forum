require 'rails_helper'

RSpec.describe LikesController do
    
    describe 'POST create' do
        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:discussion) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user.id}
        let(:reply) { create :reply, reply: 'gynyun', discussion_id: discussion.id, user_id: user.id}
        let(:channel) { create :channel, channel: 'hbhirfk', discussion_id: discussion.id}
        let(:like) { create :like, user_id: user.id, likeable_id: discussion.id, likeableType: 'Discussion'}
        
        before(:each) do
            sign_in(user)
        end

        it 'should accepts the params with html format' do
            post :create, params: {
                like: {
                    user_id: user.id,
                    likeable_id: discussion.id,
                    likeableType: 'Discussion'
                }
            }
            expect(response.media_type).to eq('text/html')
            expect(response.content_type).to eq('text/html; charset=utf-8')
        end

        it 'should include the error messages for empty attributes' do
            post :create, params: {
                like: {
                    user_id: user.id,
                    likeable_id: discussion.id,
                    likeableType: 'Discussion'
                }
            }
            expect(assigns(:like).valid?).to eq(false)
        end

    end

    describe 'DELETE destroy' do

        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:discussion) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user.id}
        let(:reply) { create :reply, reply: 'gynyun', discussion_id: discussion.id, user_id: user.id}
        let(:channel) { create :channel, channel: 'hbhirfk', discussion_id: discussion.id}
        let(:like) { create :like, user_id: user.id, likeable_id: discussion.id, likeable_type: 'Discussion'}

        before(:each) do
            sign_in(user)
        end
    
        it 'should reduce the like count by one' do
           delete :destroy, params: {
            id: like.id,
            user_id: user.id,
            likeableType: 'Discussion'
           }
            expect(Like.count).to eq(0)
        end
    end
end