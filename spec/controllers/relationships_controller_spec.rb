require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  describe "POST #create" do
    let(:followed_user) { User.create!(id: 4, name: 'user1', email: 'we@we.com', password: 'password') }
    let(:current_user) { User.create!(id: 5, name: 'user2', email: 'wq@we.com', password: 'password') }
    before do
      sign_in followed_user 
      sign_in current_user 
      allow(controller).to receive(:current_user).and_return(current_user)
      post :create, params: { followed_id: followed_user.id }
     
    end
    it "creates a relationship where the current user follows another user" do
      expect(current_user.following?(followed_user)).to be true
    end

    it "redirects to the followed user's page" do
      expect(response).to redirect_to(followed_user)
    end
  end


  describe 'DELETE #destroy' do
    let(:user) { User.create!(id: 4, name: 'user1', email: 'we@we.com', password: 'password') }
    let(:other_user) { User.create!(id: 5, name: 'user2', email: 'w2@we.com', password: 'password') }
    let(:relationship) { Relationship.create(follower_id: user.id, followed_id: other_user.id) }

  
    before { sign_in(user) }

    it 'destroys the requested relationship' do
      delete :destroy, params: { id: relationship.id }
        expect(user.following?(other_user)).to be_falsey
    end

    it 'redirects to the followed user' do
      delete :destroy, params: { id: relationship.id }
      expect(response).to redirect_to(other_user)
    end
  end
end

