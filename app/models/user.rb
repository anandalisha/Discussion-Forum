class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, format: URI::MailTo::EMAIL_REGEXP, presence: true, uniqueness: true

  #before_create :check_for_login

  #before_save :check_email_present

  has_many :discussions, dependent: :destroy
  has_many :likes
  has_many :channels, through: :discussions
  has_many :replies
  has_one :role, dependent: :destroy

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks
  
  def self.authenticate(email,password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  #def check_for_login
   # self.login = email if login.blank?
  #end

end
