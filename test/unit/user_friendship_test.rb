require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to :user
  should belong_to :friend
end
