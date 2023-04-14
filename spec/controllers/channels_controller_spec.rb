require 'rails_helper'

RSpec.describe ChannelsController do
    describe 'GET index' do
        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:discussion) { create :discussion, title: 'gynyun', content: 'gbnufnyu rvjutun', user_id: 1}
        let(:channel) { create :channel, channel: 'hbhirfk', discussion_id: discussion.id}

        before(:each) do
            sign_in(user)
            get :index
        end
        
        #it 'assigns @channels' do
        #   expect(assigns(:channels)).to eq([channel])
        #end

        it 'renders the index template' do
            expect(response).to render_template('index')
        end

        it 'returns the status code ok' do
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'POST create' do
        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:discussion) { create :discussion, title: 'gynyun', content: 'gbnufnyu rvjutun', user_id: user.id}

        before(:each) do
            sign_in(user)
        end

        it 'should accepts the params with html format' do
            post :create, params: {
                channel: {
                    channel: 'hbhirfk',
                    discussion_id: discussion.id
                }
            }
            expect(response.media_type).to eq('text/html')
            expect(response.content_type).to eq('text/html; charset=utf-8')
        end

        it 'should include the error messages for empty attributes' do
            post :create, params: {
                channel: {
                    channel: 'hbhirfk',
                    discussion_id: discussion.id
                }
            }
            expect(assigns(:channel).valid?).to eq(true)
        end

    end
    
    
    describe 'PATCH update' do
            let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
            let(:discussion) { create :discussion, title: 'discussion1', content: 'hbfhhuu chiufh8i jihcrujf', user_id: user.id}
            let(:channel) { create :channel, channel: 'hbhirfk', discussion_id: discussion.id}
            let(:channel1) { create :channel, channel: 'hbhcfirfk', discussion_id: discussion.id}
    
            before(:each) do
                sign_in(user)
            end
    
            it 'should accepts the params with html format' do
                patch :update, params: {
                    channel: {
                        channel: 'hbhirfk',
                        discussion_id: discussion.id
                    },
                    id: channel.id
                }
                expect(response.media_type).to eq('text/html')
                expect(response.content_type).to eq('text/html; charset=utf-8')
            end

            it 'should include the error messages for empty attributes' do
                patch :update, params: {
                    channel: {
                        channel: nil,
                        discussion_id: discussion.id
                    },
                    id: channel.id
                }
                expect(assigns(:channel).valid?).to eq(true)
            end

    end

    describe 'DELETE destroy' do

        let(:user) { create :user, username: 'testuser', email: 'test@user.com', password: 'testuser', password_confirmation: 'testuser' }
        let(:discussion) { create :discussion, title: 'gynyun', content: 'gbnufnyu rvjutun', user_id: 1}
        let(:channel) { create :channel, channel: 'hbhirfk', discussion_id: discussion.id}

        before(:each) do
            sign_in(user)
        end
    
        it 'should reduce the channel count by one' do
           delete :destroy, params: {
            id: channel.id,
            discussion_id: discussion.id
           }
            expect(Channel.count).to eq(1)
        end
    end
end