class Course < ApplicationRecord
  validates :title,  presence: true
  validates :description, presence: true, length: { :minimum => 5 }
    
  belongs_to :user
  has_many :reviews
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
    def to_s
    title
  end
  has_rich_text :description
end
