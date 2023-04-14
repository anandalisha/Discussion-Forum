require 'rails_helper'

RSpec.describe DiscussionsController do
    describe 'GET index' do
        let(:discussion) { create :discussion, title: 'gynyun', content: 'gbnufnyu rvjutun', user_id: 1}
        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }

        before(:each) do
            sign_in(user)
            get :index
        end
        
        it 'assigns @discussions' do
           
            expect(assigns(:discussions)).to eq([discussion])
        end

        it 'renders the index template' do
            expect(response).to render_template('index')
        end

        it 'returns the status code ok' do
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'POST create' do
        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }

        before(:each) do
            sign_in(user)
        end

        it 'should accepts the params with html format' do
            post :create, params: {
                discussion: {
                    title: Faker::Movie.title,
                    content: Faker::Hipster.sentences.sample,
                    channel: 'dfthyum', 
                    user_id: user.id
                }
            }
            expect(response.media_type).to eq('text/html')
            expect(response.content_type).to eq('text/html; charset=utf-8')
        end

        it 'should include the error messages for empty attributes' do
            post :create, params: {
                discussion: {
                    title: nil,
                    content: nil,
                    channel: 'dfthyum', 
                    user_id: user.id
                }
            }
            expect(assigns(:discussion).valid?).to eq(false)
        end

    end
    
    
    describe 'PATCH update' do
            let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
            let(:user1) { create :user, username: 'testuser1', email: 'test@user1.com', password: 'testuser1', password_confirmation: 'testuser1'}
            let(:user2) { create :user, username: 'testuser2', email: 'test@user2.com', password: 'testuser2', password_confirmation: 'testuser2'}
            let(:discussion) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user.id}
            let(:discussion1) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user1.id}
    
            before(:each) do
                sign_in(user)
            end
    
            it 'should accepts the params with html format' do
                patch :update, params: {
                    discussion: {
                        title: Faker::Movie.title,
                        content: Faker::Hipster.sentences.sample,
                        channel: 'dfthyum', 
                        user_id: user.id, 
                    }, 
                    id: discussion.id
                }
                expect(response.media_type).to eq('text/html')
                expect(response.content_type).to eq('text/html; charset=utf-8')
            end

            it 'should include the error messages for empty attributes' do
                patch :update, params: {
                    discussion: {
                        title: nil,
                        content: nil,
                        channel: 'dfthyum', 
                        user_id: user.id,
                    },
                    id: discussion1.id
                }
                expect(assigns(:discussion).valid?).to eq(false)
            end

    end

    describe 'DELETE destroy' do

        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:user1) { create :user, username: 'testuser1', email: 'test@user1.com', password: 'testuser1', password_confirmation: 'testuser1'}
        let(:discussion1) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user.id}

        before(:each) do
            sign_in(user)
        end
    
        it 'should reduce the discussion count by one' do
           delete :destroy, params: {
            id: discussion1.id,
            channel: 'dfthyum'
           }
            expect(Discussion.count).to eq(0)
        end
    end
end