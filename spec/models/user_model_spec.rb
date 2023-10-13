require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }


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
  
  describe '#follow' do
    it 'creates a new active relationship' do
      expect { user1.follow(user2) }.to change(user1.active_relationships, :count).by(1)
    end
  end

  describe '#unfollow' do
    before do
      user1.follow(user2)
    end

    it 'deletes an existing active relationship' do
      expect { user1.unfollow(user2) }.to change(user1.active_relationships, :count).by(-1)
    end
  end

  describe '#following?' do
    context 'when user1 follows user2' do
      before do
        user1.follow(user2)
      end

      it 'returns true' do
        expect(user1.following?(user2)).to be true
      end
    end

    context 'when user1 does not follow user2' do
      it 'returns false' do
        expect(user1.following?(user2)).to be false
      end
    end
  end

    
end

