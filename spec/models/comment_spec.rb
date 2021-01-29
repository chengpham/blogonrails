require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validates" do
    describe 'body' do  
      it 'requires a body' do
        comment=FactoryBot.build(:comment, body: nil)
        comment.valid?
        expect(comment.errors.messages).to(have_key(:body))
      end
    end
  end
end
