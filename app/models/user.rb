class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :email, uniqueness: true
  validates :email, presence: true, length: { minimum: 3 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
