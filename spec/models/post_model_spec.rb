require 'rails_helper'
RSpec.describe Post, type: :model do
 
it 'columns', :aggregate_failures do
    is_expected.to have_db_column(:content).of_type(:text)
    is_expected.to have_db_column(:user_id).of_type(:integer)
    is_expected.to have_db_column(:picture).of_type(:string)
    is_expected.to have_db_column(:created_at).of_type(:datetime)
    is_expected.to have_db_column(:updated_at).of_type(:datetime)
end
     
it 'associations', :aggregate_failures do
    is_expected.to belong_to(:user)
    is_expected.to have_many(:comments).dependent(:destroy)
    is_expected.to have_many(:likes).dependent(:destroy)
end

  
      
describe 'validations' do
    let(:user) { create(:user) }
    it 'is valid with valid attributes' do
      post = build(:post, user: user, content: 'Content')
      expect(post).to be_valid
    end
      
    it 'is not valid without a content' do
      post = build(:post, user: user, content: nil)
      expect(post).not_to be_valid
    end
      
    it 'is not valid without a user' do
      post = build(:post, user_id: nil, content: 'Content')
      expect(post).not_to be_valid
    end
end
end