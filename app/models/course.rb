class Course < ApplicationRecord
  validates :title,  presence: true
  validates :description, presence: true, length: { :minimum => 5 }
    
  belongs_to :user
  has_many :reviews

    def to_s
    title
  end
  has_rich_text :description
end
