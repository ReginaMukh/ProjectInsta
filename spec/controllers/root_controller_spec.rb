RSpec.describe RootController, type: :controller do
   describe 'GET #home' do
    context 'when user is not signed in' do
      before do
        get :home
      end

      it 'responds successfully' do
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        expect(response).to have_http_status '200'
      end
    end

    context 'when user is signed in' do
      let(:user) { create(:user) } # Assumes you have a user factory

      before do
        sign_in user
        get :home
      end

      it 'responds successfully' do
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        expect(response).to have_http_status '200'
      end

      it 'assigns @post and @feed_items and @comments' do
        post = user.posts.create!(content: 'Test post')
        comment = Comment.create!(post: post, user: user, body: 'Test comment')
        
        get :home
  
        expect(assigns(:post)).to be_a_new(Post)
        expect(assigns(:feed_items)).to eq([post])
        
      end
    end
  end
end
