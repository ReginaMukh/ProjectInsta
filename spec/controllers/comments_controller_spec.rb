require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment) }

  describe '#create' do
    it 'create a new comment' do
      expect { comment }.to change(Comment, :count).by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe '#destroy' do
    before { sign_in(user) }
    it 'destroys comment' do
      post 
      comment
      expect { delete :destroy, params: { id: comment.to_param }
      }.to change(Comment, :count).by(-1)
    end

    it 'redirects to the root_path' do
      delete :destroy, params: { id: comment.to_param }
      expect(response).to redirect_to(root_url)
    end
  end
end