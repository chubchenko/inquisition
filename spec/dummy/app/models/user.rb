class User < ApplicationRecord
  has_many :projects

  validates :email, :password_digest, presence: true
end
