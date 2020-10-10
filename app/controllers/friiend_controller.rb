class FriiendsController < ApplicationController
    before_action :authenticate_user!
    def create
        @user = User.find(params[:user_id][:follower_id])
        #current_user.follow!(@user)
        redirect_to @user
    end
    def destroy
        @user = Friiend.find(params[:id])
        #current_user.unfollow!(@user)
    end
    
end 
