class Question < ActiveRecord::Base

  has_many :answers
  belongs_to :user

  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%")
    else
      all
    end
  end
end
