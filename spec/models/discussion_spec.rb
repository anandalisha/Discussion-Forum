require 'rails_helper'

RSpec.describe Discussion, type: :model do
    #current_user = User.first_or_create!(email: 'test@user.com', encrypted_password: 'testuser', username: 'testuser')

    context 'when creating a discussion' do
        let(:discussion) { build :discussion }
        let(:discussion1) { create :discussion, title: nil}
        let(:discussion2) { create :discussion, content: nil}
    
        it 'should be valid user with all attributes' do
          expect(discussion.valid?).to eq(false)
        end
    
        it 'title cannot be nil' do
          expect(discussion1.valid?).to eq(true)
        end
    
        it 'content cannot be nil' do
            expect(discussion2.valid?).to eq(true)
        end
    end
end


    #it 'has a title' do
    #   discussion = Discussion.new(
    #        title: '',
    #        content: 'A valid body',
    #       user_id: current_user.id,
    #       channel_id: 2

    #   )
    #   expect(discussion).to_not be_valid

    #    discussion.title = "Has a title"
    #   expect(discussion). to be_valid 
    #end

    #it 'has a body' do
    #   discussion = Discussion.new(
    #       title: 'A valid title',
    #       content: '',
    #       user_id: current_user.id,
    #       channel_id: 2

    #   )
    #   expect(discussion).to_not be_valid

    #   discussion.content = "Has some content"
    #   expect(discussion). to be_valid 
    #end
