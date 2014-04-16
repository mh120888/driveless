class ProfilesController < ApplicationController
  def show
    @user = User.find_by_profile_name(params[:id])
    if @user 
      @statuses = @user.statuses
      @pending_requests = UserFriendship.where(state:'pending', friend_id: @user.id)
      render action: :show
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end
end
