require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    describe '#new' do
        context "with signed in user" do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            it 'render the new template' do
                get(:new)
                expect(response).to(render_template(:new)) 
            end
            it 'sets an instance variable with new posts' do
                get(:new)
                expect(assigns(:posts)).to(be_a_new(Post))
            end
        end 
        context 'with user not signed in'do
            it 'should redirect to sign in page' do
                get(:new)
                expect(response).to redirect_to(new_session_path)
            end
        end
    end
    describe '#create' do
        def valid_request
            post(:create, params:{post: FactoryBot.attributes_for(:post)})
        end
        context 'with user signed in' do
            before do
                session[:user_id]=FactoryBot.create(:user)
            end
            context " with valid parameter " do 
                it 'creates a post in the database' do
                    count_before = Post.count
                    valid_request
                    count_after=Post.count
                    expect(count_after).to(eq(count_before + 1))
                end
                it 'redirects us to a show page of that post' do
                    valid_request
                    post=Post.last
                    expect(response).to(redirect_to(post_url(post.id)))
                end
            end
            context 'with invalid parameters' do
                def invalid_request
                    post(:create, params:{post: FactoryBot.attributes_for(:post, title: nil)})
                end
                it 'doesnot save a record in the database'do
                    count_before = Post.count
                    invalid_request
                    count_after = Post.count
                    expect(count_after).to(eq(count_before))
                end
                it 'renders the new template' do
                    invalid_request
                    expect(response).to render_template(:new)
                end
            end
        end
        context 'with user not signed in'do
            it 'should redirect to sign in page' do
                valid_request
                expect(response).to redirect_to(new_session_path)
            end
        end
    end
    describe '#show' do
        it 'render show template' do
            post=FactoryBot.create(:post)
            get(:show, params:{id: post.id})
            expect(response).to render_template(:show)
        end
        it 'set an instance variable post for the shown object' do
            post=FactoryBot.create(:post)
            get(:show, params:{id: post.id})
            expect(assigns(:posts)).to(eq(post))
        end
    end
    describe '#index' do 
        it 'render the index template' do
            get(:index)
            expect(response).to render_template(:index)
        end
        it 'assign an instance variable post which contains all created posts' do
            post1=FactoryBot.create(:post)
            post2=FactoryBot.create(:post)
            post3=FactoryBot.create(:post)
            get(:index)
            expect(assigns(:posts)).to eq([post3, post2,post1])
        end
    end
    describe "# edit" do
        context "with signed in user" do
            context " as owner" do
                before do
                    @post=FactoryBot.create(:post)
                    session[:user_id] = @post.user
                end
                it "render the edit template" do
                    get(:edit, params:{id: @post.id})
                    expect(response).to render_template :edit
                end
            end
            context 'as non owner' do
                before do
                    session[:user_id] = FactoryBot.create(:user)
                    @post=FactoryBot.create(:post)
                end
                it 'should redirect to the show page' do
                    get(:edit, params:{id: @post.id})
                    expect(response).to redirect_to post_path(@post)
                end
            end
        end
    end
    describe '#update' do
        before do 
            @post= FactoryBot.create(:post)
        end
        context "with signed in user"do
            before do
                session[:user_id] = @post.user.id
            end
            context "with valid parameters" do
                it "update the post record with new attributes" do
                    new_title = "#{@post.title} plus some changes!!!"
                    patch(:update, params:{id: @post.id, post: {title: new_title}})
                    expect(@post.reload.title).to(eq(new_title))
                end
                it 'redirect to the show page' do
                    new_title = "#{@post.title} plus some changes!!!"
                    patch(:update, params:{id: @post.id, post: {title: new_title}})
                    expect(response).to redirect_to(@post)
                end
            end
            context "with invalid parameters" do
                it 'should not update the post record' do
                    patch(:update, params:{id: @post.id, post: {title: nil}})
                    expect(@post.reload.title).to(eq(@post.title))
                end
            end
        end
    end
    describe '#destroy' do
        context "with signed in user" do
            context 'as owner' do
                before do
                    @post=FactoryBot.create(:post)
                    session[:user_id] = @post.user
                    delete(:destroy, params:{id: @post.id})
                end
                it 'remove post from the db' do
                    expect(Post.find_by(id: @post.id)).to(be(nil))
                end
                it 'redirect to the postindex' do
                    expect(response).to redirect_to(posts_path)
                end
                it 'set a flash message' do
                    expect(flash[:danger]).to be
                end 
            end
            context "as non owner" do
                before do
                    session[:user_id]=FactoryBot.create(:user)
                    @post=FactoryBot.create(:post)
                end
                it 'does not remove the post' do
                    delete(:destroy,params:{id: @post.id})
                    expect(Post.find(@post.id)).to eq(@post)
                end
            end
        end
    end
end
