class UserFriendshipsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def new
    if params[:friend_id]
      @friend = User.find(params[:friend_id])
      @user_friendship = UserFriendship.new(friend: @friend, user: current_user)
    else
      flash[:error] = 'Friend required'
    end
    rescue ActiveRecord::RecordNotFound
      render file: 'public/404', status: :not_found
  end

  def create
    if params[:user_friendship]
      @friend = User.find(params[:user_friendship][:friend_id])
      @user_friendship = UserFriendship.new(friend: @friend, user: current_user)
      @user_friendship.save
      redirect_to profile_path(@friend)
      flash[:success] = "You are now friends with #{@friend.full_name}"
    else
      flash[:error] = 'Friend is needed'
      redirect_to root_path
    end
  end

end
