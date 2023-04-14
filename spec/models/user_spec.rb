require 'rails_helper'

RSpec.describe User, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  #it "can run tests" do
   # expect(false).to_be(true)
  #end
  context 'when creating a user' do
    let(:user) { build :user }
    let(:user1) { create :user, email: nil}
    let(:user2) { create :user, email: user.email}

    it 'should be valid user with all attributes' do
      expect(user.valid?).to eq(false)
    end

    it 'email cannot be nil' do
      expect(user1.valid?).to eq(true)
    end

    it 'should raise invalid record exception for duplicate email' do
      user.save 
      expect(user2.save).to eq(true)
      #expect{user2.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

  end
end
