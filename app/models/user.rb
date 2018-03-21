class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :proposals

  validates :name, :email, :phone, presence: true

  has_attached_file :image, default_url: '/image.jpg'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
