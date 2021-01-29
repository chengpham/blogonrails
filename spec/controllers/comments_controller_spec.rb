require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
    describe '#create' do
        context 'with user signed in' do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            context " with valid parameter " do 
                def valid_request
                    post = FactoryBot.create(:post)
                    post(:create, params:{comment: FactoryBot.attributes_for(:comment), post_id: post} )
                end
                it 'creates a comment in the database' do
                    count_before = Comment.count
                    valid_request
                    count_after=Comment.count
                    expect(count_after).to(eq(count_before + 1))
                end
                it 'redirects us to a show page of that comment' do
                    valid_request
                    comments = Comment.last
                    expect(response).to(redirect_to(post_url(comments.post_id)))
                end
            end
            context 'with invalid parameters' do
                def invalid_request
                    post = FactoryBot.create(:post)
                    post(:create, params:{comment: FactoryBot.attributes_for(:comment, body: nil), post_id: post})
                end
                it 'does not save a record in the database'do
                    count_before = Comment.count
                    invalid_request
                    count_after = Comment.count
                    expect(count_after).to(eq(count_before))
                end
            end
        end
    end
    describe '#destroy' do
        before do
            current_user=FactoryBot.create(:user)
            session[:user_id]=current_user.id
            @comments=FactoryBot.create(:comment, user: current_user)
            delete(:destroy, params:{id: @comments.id, post_id: @comments.post.id})
        end
        it 'remove comment from the database' do
            expect(Comment.find_by(id: @comments.id)).to(be(nil))
        end
        it 'redirect to the post index' do
            expect(response).to redirect_to post_path(@comments.post.id)
        end
    end
end
