require 'spec_helper'

describe Micropost do
	
	let(:user) { FactoryGirl.create(:user) }
	before { @micropost = user.microposts.build(content: "Lorem ipsim") }

	subject { @micropost }

	it { should respond_to(:content) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	its(:user) { should == user }   # see listing 10.8

	it { should be_valid }

	describe "when user_id is not present" do 
		before { @micropost.user_id = nil }
		it { should_not be_valid }
	end

  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end
  
  describe "with content that is too long" do
    before { @micropost.content = "a" * 181 }
    it { should_not be_valid }
  end

	describe "accessible attributes" do 
		it "should not allow access to user_id" do 
			expect do 
				Micropost.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		# This test verifies that calling Micropost.new 
		# with a nonempty user_id raises a mass assignment 
		# security error exception. This behavior is on by 
		# default as of Rails 3.2.3, but previous versions 
		# had it off, so you should make sure that your application 
		# is configured properly in config/application.rb
		# see listings 10.5 and 10.6
		end
	end  # of describe "accessible attributes"


end  # of describe Micropost
