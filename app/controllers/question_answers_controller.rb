class QuestionAnswersController < ApplicationController
  skip_before_action :require_login
  
  def result
    @question = Question.find(params[:question_id])
    @choices = @question.choices
    @selected_choice = @question.choices.find(params[:selected_choice_id]) if params[:selected_choice_id]
  end
end
