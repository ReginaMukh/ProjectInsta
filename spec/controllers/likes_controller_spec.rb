require 'rails_helper'

RSpec.describe LikesController, type: :controller do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:like) { create(:like) }
        
    describe '#create' do
    before { sign_in(user) }
      it 'create a like' do
        expect { like }.to change(Like, :count).by(1)
        expect(response).to have_http_status(200)
      end
    end

    describe '#destroy' do
    before { sign_in(user) }
    subject { delete :destroy, params: { id: like.id } }
      it 'delete a like' do
        expect { subject }.to change(Like, :count).by(0)
        expect(response).to have_http_status(302)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_url)
      end
    end

end