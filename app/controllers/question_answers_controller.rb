class QuestionAnswersController < ApplicationController
  skip_before_action :require_login
  
  def result
    @question = Question.find(params[:question_id])
    @choices = @question.choices
  end
end
