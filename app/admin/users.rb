ActiveAdmin.register User do

  index do
    column :id
    column :email
    column "following" do |user|
      user.active_relationships.select(:follower_id).count
    end
    column "tweets" do |user|
      user.tweets.count
    end
    column :retweets
    column "Likes" do |user|
      user.likes.count
    end
    actions

  end

  filter :create_at

  permit_params do
    permitted = [:email,:encrypted_password, :name, :avatar_url, :reset_password_token, :reset_password_sent_at, :remember_created_at]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

end
