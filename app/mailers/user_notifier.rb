class UserNotifier < ActionMailer::Base
  default from: "from@example.com"

  def friend_requested_email(user_friendship_id)
    user_friendship = UserFriendship.find(user_friendship_id)

    @user = user_friendship.user
    @friend = user_friendship.friend

    mail to: @friend.email,
      subject: "#{@user.first_name} would like to be friends on DriveLess"
  end

  def friend_accepted_email(user_friendship_id)
    user_friendship = UserFriendship.find(user_friendship_id)

    @user = user_friendship.user
    @friend = user_friendship.friend

    mail to: @user.email,
      subject: "#{@friend.first_name} accepted your request to be friends on DriveLess"
  end
end
