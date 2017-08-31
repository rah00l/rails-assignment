class User < ActiveRecord::Base

  has_many :questions#, inverse_of: :asker
  has_many :answers#, inverse_of: :answerer
  belongs_to :tenant
end
