class User < ActiveRecord::Base
# Explicitly defining accessible attributes is crucial for good site security. 
# If we omitted the attr_accessible list in the User model (or foolishly added :admin to the list), 
#   a malicious user could send a PUT request as follows:    put /users/17?admin=1
# Because of this danger, it is a good practice to define attr_accessible for every model.
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :microposts, dependent: :destroy
  # dependent: :destroy arranges for the dependent microposts 
  # (i.e., the ones belonging to the given user) to be destroyed 
  # when the user itself is destroyed. This prevents userless microposts 
  # from being stranded in the database when admins choose to 
  # remove users from the system.

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
  					format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  after_validation { self.errors.messages.delete(:password_digest) }

  def feed
    # this is prelim - see See "Following users" for the full implementation.
    Micropost.where("user_id = ? ", id)
    # microposts
  end

  private 
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

