class Question < ActiveRecord::Base
  default_scope { where(private: false) }
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
