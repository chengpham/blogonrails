require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validates" do
    describe "title" do
      it "requires a title" do
        post = FactoryBot.build(:post, title: nil)
        post.valid?
        expect(post.errors.messages).to(have_key(:title))
      end
      it 'title is unique' do
        persisted_post= FactoryBot.create(:post)
        post=FactoryBot.build(:post, title: persisted_post.title)
        post.valid?
        expect(post.errors.messages).to(have_key(:title))
      end
    end
    describe 'body' do  
      it 'requires body greater than 50 characters' do
        post=FactoryBot.build(:post, body: nil)
        post.valid?
        expect(post.errors.messages).to(have_key(:body))
      end
    end
  end
end
