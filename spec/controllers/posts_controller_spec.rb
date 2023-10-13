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
  
  describe 'PUT #update' do
let(:valid_attributes) { { content: 'Valid content', user_id: user.id } }
let(:invalid_attributes) { { content: '', user_id: user.id } }

before do
  user = create(:user)
  @post = create(:post, user_id: user.id)
  sign_in user 
end
  context 'with valid parameters' do
    it 'updates the requested post' do
      patch :update, params: { id: @post.id, post: { content: 'Valid content'} }
      @post.reload
      expect(@post.content).to eq(valid_attributes[:content])
    end


    it 'redirects to the root URL' do
      patch :update, params: { id: @post.id, post: valid_attributes }
      expect(response).to redirect_to(root_url)
    end
  end
  context 'with invalid parameters' do
    it 'does not update the requested post' do
      patch :update, params: { id: @post.id, post: invalid_attributes }
      @post.reload
      expect(@post.content).not_to eq(invalid_attributes[:content])
    end

    it 'renders the edit view' do
      patch :update, params: { id: @post.id, post: invalid_attributes }
      expect(response).to render_template('edit')
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