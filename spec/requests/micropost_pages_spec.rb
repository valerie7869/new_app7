require 'spec_helper'
# this file created when running: rails generate integration_test micropost_pages
describe "Micropost pages" do
  
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do   # 10.29
  	before { visit root_path }

  	describe "with invalid information" do   # 10.29

  		it "should not create a micropost" do 
  			expect { click_button "Post" }.not_to change(Micropost, :count)
  		end

  		describe "error messages" do 
  			before { click_button "Post" }
  			it { should have_content('error') }
  		end
  	end  # of describe "with invalid information"

  	describe "with valid information" do     # 10.29

  		before { fill_in 'micropost_content', with: "Lorem ipsum" }
  		it "should create a micropost" do 
  			expect { click_button "Post" }.to change(Micropost, :count).by(1)
  		end
  	end # of describe "with valid information"

  end # of describe "micropost creation"

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }
    
    describe "as correct user" do
      before { visit root_path }
      
      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end  # of describe "as correct user"
  end # of describe "micropost destruction"

end # of describe "Micropost pages"
