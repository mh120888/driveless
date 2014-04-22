class UserFriendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  validates_uniqueness_of :user_id, :scope => :friend_id
  validate :cannot_already_be_friends, :on => :create

  attr_accessible :user, :friend, :user_id, :friend_id

  state_machine :state, :initial => :pending do

    after_transition on: :accept, do: :send_acceptance_email

    event :accept do
      transition any => :accepted
    end 
  end

  def send_request_email
    UserNotifier.friend_requested_email(id).deliver
  end

  def send_acceptance_email
    UserNotifier.friend_accepted_email(id).deliver
  end

  def reject!
    self.destroy
  end

  def cannot_already_be_friends
    errors.add(:friends, 'They are already friends') if self.user.already_friends_with?(self.friend)
  end
end
