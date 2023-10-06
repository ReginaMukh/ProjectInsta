require 'rails_helper'

RSpec.describe User, type: :model do

    it 'columns', :aggregate_failures do
        is_expected.to have_db_column(:name).of_type(:string)
        is_expected.to have_db_column(:email).of_type(:string)
        is_expected.to have_db_column(:encrypted_password).of_type(:string)
        is_expected.to have_db_column(:created_at).of_type(:datetime)
        is_expected.to have_db_column(:updated_at).of_type(:datetime)
        end
         
        it 'associations', :aggregate_failures do
       
        is_expected.to have_many(:posts).dependent(:destroy)
        is_expected.to have_many(:likes).dependent(:destroy)
        is_expected.to have_many(:comments).dependent(:destroy)
        is_expected.to have_many(:active_relationships).class_name('Relationship').dependent(:destroy)
        is_expected.to have_many(:passive_relationships).class_name('Relationship').dependent(:destroy)
        is_expected.to have_many(:following).through(:active_relationships)
        is_expected.to have_many(:followers).through(:passive_relationships)
        end


 

  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user, email: 'ul@2.com', password: 'password')
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil, password: 'password')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = build(:user, email: '1@2.3', password: nil)
      expect(user).not_to be_valid
    end
  end

  

  describe 'follow' do
    let(:user) { create(:user) }
    
    it 'should follow a user' do
      other_user = create(:user)
      expect {user.follow(other_user)}.to change(Relationship, :count).by(1)
      expect(user.following?(other_user)).to be_truthy
    end
end

describe 'unfollow' do
    let(:user) { create(:user) }
    it 'should unfollow a user' do
         other_user = create(:user)
      subject { delete :unfollow, params: { followed_id: other_user.id } }
      expect {user.unfollow(other_user)}.to change(Relationship, :count).by(0)
      expect(user.following?(other_user)).to be_falsey
   
    end
    
  end
end

