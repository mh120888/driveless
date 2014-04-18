class UserFriendshipsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :update]

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
      if @user_friendship.save
        redirect_to profile_path(@friend)
        flash[:success] = "You have requested to be friends with #{@friend.full_name}"
      else
        flash[:error] = "You are already friends with #{@user_friendship.friend.full_name}!"
        redirect_to feed_path
      end
    else
      flash[:error] = 'Friend is needed'
      redirect_to root_path
    end
  end

  def update
    @friend = User.find(params[:user_id])
    if @user_friendship = UserFriendship.where(friend_id: current_user.id, user_id: @friend.id).first
      if @user_friendship.accept!
        redirect_to profile_path(current_user)
        flash[:success] = "You are now friends with #{@friend.full_name}"
      end
    else
      flash[:error] = 'This isn\'t working...sorry! Please try again later.'
      redirect_to root_path
    end
  end

  def destroy
    if current_user
      @user_friendship = UserFriendship.find(params[:id])
      @user_friendship.destroy
      redirect_to profile_path(current_user)
    else
      redirect_to new_user_session_path
    end
  end

end
