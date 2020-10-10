class FriiiendsController < ApplicationController
    before_action :authenticate_user!
    def create
        @user = User.find(params[:follower_id])
        @friiiend = Friiiend.new(user_id: current_user.id, follower_id: @user.id)
        respond_to do |format|
            if current_user.following?(@user)
                format.html { redirect_to @user, notice: 'Este usuario ya esta esta siendo seguido.' }
            else
            if @friiiend.save
                format.html { redirect_to @user, notice: 'Usuario seguido con exito.' }
                format.json { render :show, status: :created, location: @friiiend }
            else
                format.html { render :new }
                format.json { render json: @friiiend.errors, status: :unprocessable_entity }
            end
            end
        end
    end
    def destroy
        @user = Friiiend.find_by(follower_id: params[:id], user_id: current_user.id).follower
        current_user.unfollow!(@user)
        redirect_to user_path(@user)
        #@user = Friiiend.find(params[:id])
    end
    
end 
