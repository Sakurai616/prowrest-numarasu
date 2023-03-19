class TakeQuizzesController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  
  def index
    @user = User.find(params[:user_id])
    @quiz_1, @quiz_2, @quiz_3 = @user.questions.sample(3)
    @choices_1, @choices_2, @choices_3 = [@quiz_1, @quiz_2, @quiz_3].map(&:choices)
    @num_1, @num_2, @num_3 = [1, 2, 3]
  end
end
