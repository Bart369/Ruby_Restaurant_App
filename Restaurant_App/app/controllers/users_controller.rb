class UsersController < ApplicationController

    before_action :ensure_signed_in, only: [:show]

    def new
        @user = User.new
    end

    def create
        @user = User.new(create_params)

        if @user.save
        sign_in(@user)
        flash[:notice] = 'You are signed in!'
        redirect_to users_path
        else
        flash[:error] = @user.errors.full_messages.join(', ')
        render :new
        end
    end

    def show
        @user = User.find(params[:id])
    end

    private

    def create_params
        params.require(:user).permit(:username, :password)
    end

end