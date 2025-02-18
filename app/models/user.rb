class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  belongs_to :corporation, optional: true
end
