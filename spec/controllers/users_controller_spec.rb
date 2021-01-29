require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe '#new' do
        context "with signed in user" do
            it 'render the new template' do
                get(:new)
                expect(response).to(render_template(:new)) 
            end
            it 'sets an instance variable with new user' do
                get(:new)
                expect(assigns(:user)).to(be_a_new(User))
            end
        end 
    end
    describe '#create' do
        context 'with user signed in' do
            context " with valid parameter " do 
                it 'creates a user in the database' do
                    count_before = User.count
                    session[:user_id]=FactoryBot.create(:user)
                    count_after=User.count
                    expect(count_after).to(eq(count_before + 1))
                end
                it 'should redirect user after sign in' do
                    user=FactoryBot.attributes_for(:user)
                    post(:create, params:{user: user})
                    expect(response).to redirect_to(root_path)
                end
            end
            context 'with invalid parameters' do
                it 'should redirect user if not signed in' do
                    post(:create, params:{user: FactoryBot.attributes_for(:user, email: nil)})
                    expect(response).to render_template(:new)
                end
            end
        end
    end
end
