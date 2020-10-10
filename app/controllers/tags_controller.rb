class TagsController < ApplicationController
    before_action :authenticate_user!

    def index
        @tags = Tag.all
    end

    def show
        @tag = Tag.find(params[:id])
        @tweets = @tag.tweets.all
    end
end