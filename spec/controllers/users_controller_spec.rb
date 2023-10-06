require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#show' do
    let(:user) { FactoryBot.create(:user) }
    subject { get :show, params: { id: user.id } }

    context 'when user not logged in' do
      it 'should be redirected to sign-in form', :aggregate_failures do
        subject
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is logged in' do
      before { sign_in user }
      it 'should return 200', :aggregate_failures do
        subject
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
      end

    end
  end
    
  describe '#update' do
    let(:user) { FactoryBot.create(:user) }
    let(:new_email) { FFaker::Internet.email }

    before { sign_in user }

    context 'with valid attributes' do
      it 'updates the user profile' do
      patch :update, params: { id: user.id, user: { email: new_email } }
      user.reload
      expect(user.email).to eq(new_email)
    end

      it 'redirects to the user profile' do
      patch :update, params: { id: user.id, user: { email: new_email } }
      expect(response).to redirect_to(user_path(user))
    end
  end

    context 'with invalid attributes' do
      let(:invalid_email) { "invalid" }

    it 'does not update the user profile' do
      patch :update, params: { id: user.id, user: { email: invalid_email } }
      user.reload
      expect(user.email).not_to eq(invalid_email)
    end

    it 're-renders the edit template' do
      patch :update, params: { id: user.id, user: { email: invalid_email } }
      expect(response).to render_template(:edit)
    end
  end
end

  describe '#following' do
    let(:user) { FactoryBot.create(:user) }
  
    context 'is user not logged in' do  
    it 'should redirect following ' do  
      get :following, params: { id: user.id }
      expect(response).to redirect_to(new_user_session_path)
      end
  end

end
end