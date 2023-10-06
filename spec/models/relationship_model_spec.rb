require 'rails_helper'
RSpec.describe Relationship, type: :model do
 
    it 'columns', :aggregate_failures do
        is_expected.to have_db_column(:follower_id).of_type(:integer)
        is_expected.to have_db_column(:followed_id).of_type(:integer)
        is_expected.to have_db_column(:created_at).of_type(:datetime)
        is_expected.to have_db_column(:updated_at).of_type(:datetime)
    end
         
    it 'associations', :aggregate_failures do
        is_expected.to belong_to(:follower).class_name('User')
        is_expected.to belong_to(:followed).class_name('User')
    end


    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
  
    before(:each) do
      @relationship = Relationship.new(follower: user1, followed: user2)
    end
  
    it 'is valid' do
      expect(@relationship).to be_valid
    end
  
    it 'requires follower' do
      @relationship.follower = nil
      expect(@relationship).not_to be_valid
    end
  
    it 'requires followed' do
      @relationship.followed = nil
      expect(@relationship).not_to be_valid
    end
  
 
end
