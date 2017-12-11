class RestaurantsController < ApplicationController

    #this is to check if users are signed, this is coming from application controller
    before_action :ensure_signed_in

    def index
        # @restaurants = Restaurant.all changed to the below
        @restaurants = current_user.restaurants.all
    end

    def show
        @restaurant = current_user.restaurants.find(params[:id])
    end

    def new
        @restaurant = Restaurant.new
    end

    def create
        @restaurant = Restaurant.new(restaurant_params)
        # @restaurant.user = current_user

        if @restaurant.save
            flash[:notice] = 'Restaurant added to list!'
            redirect_to restaurant_path(@restaurant)
        else
            flash[:error] = @restaurant.errors.full_messages.join(', ')
            render :new
        end
    end

    def edit
        @restaurant = Restaurant.find(params[:id])
    end

    def update
        @restaurant = Restaurant.find(params[:id])
        #when we hit submit in our edit form, it gets saved at restaurant.update
        if  @restaurant.update(restaurant_params)
        redirect_to restaurant_path(@restaurant)
        else
        redirect_to restaurant_edit_path(@restaurant)
        end
    end

    def destroy 
        @restaurant = Restaurant.find(params[:id])
        if @restaurant.destroy
            redirect_to restaurants_path
        else
            redirect_to restaurant_path(@restaurant)
        end
    end

    #private must always be last
    private

    def restaurant_params
        params.require(:restaurant).permit(:name, :kind, :bestdish)
    end

end