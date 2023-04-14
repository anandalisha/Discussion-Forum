require 'rails_helper'

RSpec.describe Reply, type: :model do

    context 'when creating a reply' do
        let(:reply) { build :reply, reply: "cfrtvtb", discussion_id: 1, user_id: 1}
        let(:reply1) { create :reply, reply: nil, discussion_id: 1, user_id: 1}
    
        it 'should be valid user with all attributes' do
          expect(reply.valid?).to eq(false)
        end
    
        it 'reply cannot be nil' do
          expect(reply1.valid?).to eq(false)
        end
    end
end