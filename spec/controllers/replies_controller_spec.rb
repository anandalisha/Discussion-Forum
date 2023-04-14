require 'rails_helper'

RSpec.describe RepliesController do
   
    describe 'POST create' do
        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:discussion) { create :discussion, title: 'gynyun', content: 'gbnufnyu rvjutun', user_id: user.id}
        let(:channel) { create :channel, channel: 'hbhirfk', discussion_id: discussion.id}
        let(:reply) { create :reply, reply: 'gynyun', discussion_id: discussion.id, user_id: user.id}


        before(:each) do
            sign_in(user)
        end

        it 'should accepts the params with html format' do
            post :create, params: {
                reply: {
                    reply: 'guhhuiiok',
                    user_id: user.id 
                },
                discussion_id: discussion.id
            }
            expect(response.media_type).to eq('text/html')
            expect(response.content_type).to eq('text/html; charset=utf-8')
        end

        it 'should include the error messages for empty attributes' do
            post :create, params: {
                reply: {
                    reply: nil,
                    #discussion_id: discussion.id,  
                    user_id: user.id 
                },
                discussion_id: discussion.id
            }
            expect(assigns(:reply).valid?).to eq(false)
        end

    end
    
    
    describe 'PATCH update' do
            let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
            let(:user1) { create :user, username: 'testuser1', email: 'test@user1.com', password: 'testuser1', password_confirmation: 'testuser1'}
            let(:user2) { create :user, username: 'testuser2', email: 'test@user2.com', password: 'testuser2', password_confirmation: 'testuser2'}
            let(:discussion) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user.id}
            let(:discussion1) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user1.id}
            let(:reply) { create :reply, reply: 'gynyun', discussion_id: discussion.id, user_id: user.id}
    
            before(:each) do
                sign_in(user)
            end
    
            it 'should accepts the params with html format' do
                patch :update, params: {
                    reply: {
                        reply: 'njikodijed',
                        #discussion_id: discussion.id,  
                        user_id: user.id 
                    }, 
                    id: reply.id,
                    discussion_id: discussion.id
                }
                expect(response.media_type).to eq('text/html')
                expect(response.content_type).to eq('text/html; charset=utf-8')
            end

            it 'should include the error messages for empty attributes' do
                patch :update, params: {
                    reply: {
                        reply: nil,
                        #discussion_id: discussion.id,  
                        user_id: nil
                    },
                    id: reply.id,
                    discussion_id: discussion.id
                }
                expect(assigns(:reply).valid?).to eq(false)
            end

    end

    describe 'DELETE destroy' do

        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:user1) { create :user, username: 'testuser1', email: 'test@user1.com', password: 'testuser1', password_confirmation: 'testuser1'}
        let(:discussion) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user.id}
        let(:discussion1) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user1.id}
        let(:reply) { create :reply, reply: 'gynyun', discussion_id: discussion.id, user_id: user.id}

        before(:each) do
            sign_in(user)
        end
    
        it 'should reduce the reply count by one' do
           delete :destroy, params: {
            id: reply.id,
            discussion_id: discussion.id,  
            user_id: user.id 
           }
            expect(Reply.count).to eq(0)
        end
    end
end