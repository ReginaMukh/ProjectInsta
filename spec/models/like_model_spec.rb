require 'rails_helper'
RSpec.describe Like, type: :model do
 
    it 'columns', :aggregate_failures do
        is_expected.to have_db_column(:post_id).of_type(:integer)
        is_expected.to have_db_column(:user_id).of_type(:integer)
        is_expected.to have_db_column(:created_at).of_type(:datetime)
        is_expected.to have_db_column(:updated_at).of_type(:datetime)
    end
         
    it 'associations', :aggregate_failures do
        is_expected.to belong_to(:user)
        is_expected.to belong_to(:post)
    end

    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:like) { create(:like, post: post, user: user) }  

    describe 'validations' do
      it 'is valid with valid attributes' do
        expect(like).to be_valid
      end
  
      it 'is not valid without a user' do
        reaction = build(:like, user: nil, post: post)
        expect(reaction).not_to be_valid
      end

    end
end
  