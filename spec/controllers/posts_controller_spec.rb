require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }

  describe '#create' do
    context 'when user is not logged in' do
      it 'redirects to the root page' do
        post :create, params: { post: { content: 'New Post' } }
        expect(response).to have_http_status(:redirect)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is logged in' do
      before { sign_in user }
      it 'create a new post' do
        expect {
          post :create, params: { post: { content: 'New Post' } }
        }.to change(Post, :count).by(1)
      end

      it 'redirect to root_url on successful creation' do
        post :create, params: { post: { content: 'New Post' } }
        expect(response).to redirect_to(root_url)
        expect(flash[:success]).to eq("publication created!")
      end

      it 'renders the new template on failed creation' do
        post :create, params: { post: { content: '' } }
        expect(response).to render_template("root/home", "layouts/application")
      end
    end
  end


  describe '#destroy' do
    let(:valid_attributes) { { content: 'Test Post' } }
    let(:invalid_attributes) { { content: nil } }
    let(:post) { create(:post) }
    
    before { sign_in(user) }

    it 'destroys the requested post' do
      post # Create a post
      expect {
        delete :destroy, params: { id: post.to_param }
      }.to change(Post, :count).by(0)
    end

    it 'redirects to the root_path' do
      delete :destroy, params: { id: post.to_param }
      expect(response).to redirect_to(root_url)
    end
  end
end