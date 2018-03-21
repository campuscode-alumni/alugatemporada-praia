class Owner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :properties

  has_attached_file :avatar, default_url: '/teste.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
