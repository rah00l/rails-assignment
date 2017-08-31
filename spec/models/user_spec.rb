require 'rails_helper'

RSpec.describe User, type: :model do
	# Test association
	# it { should have_many(:questions).inverse_of(:asker) }
	# it { should have_many(:answers).inverse_of(:answerer) }
	it { should belong_to(:tenant) }
end
