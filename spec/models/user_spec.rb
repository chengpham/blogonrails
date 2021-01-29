require 'rails_helper'
RSpec.describe User, type: :model do
  describe "validates" do
    describe "name" do
      it "requires a name" do
        user = FactoryBot.build(:user, name: nil)
        user.valid?
        expect(user.errors.messages).to(have_key(:name))
      end
    end
    describe "email" do
      it "requires a email" do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors.messages).to(have_key(:email))
      end
      it 'email is unique' do
        persisted_user= FactoryBot.create(:user)
        user=FactoryBot.build(:user, email: persisted_user.email)
        user.valid?
        expect(user.errors.messages).to(have_key(:email))
      end
    end
  end
  context "full_name check" do
    it "returns full name and capitalizes it" do
      user = FactoryBot.build(:user, name: "john doe")
      expect(user.full_name).to(eq("John Doe"))
    end
  end
end