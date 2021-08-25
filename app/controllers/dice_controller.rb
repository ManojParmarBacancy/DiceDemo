class DiceController < ApplicationController

   include DiceRoller
    before_action :validate_input, only: :roll

    def home
    end

    def roll
      @result = roll_the_dice
      unless Rails.env == 'test'
        @result
      else
        render json: @result, status: :ok
      end
    end

    private

    def validate_input
       sides_array = params[:dice_sides].split(',')
       if params[:no_of_dice].to_i != sides_array.size || params[:dice_sides].empty? || params[:no_of_dice].empty?
         flash[:error] = "please provide valid input"
         render 'home'
       elsif sides_array.include?('0')
        flash[:error] = "Number sides of a die schold not be 0"
         render 'home'
       end
    end
end
