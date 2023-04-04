class QuestionsController < ApplicationController
  skip_before_action :require_login, only: %i[index show correct_result wrong_result search]
  before_action :set_question, only: %i[edit update destroy]

  def index
    @questions = Question.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @question = Question.new
    @question.choices.build
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path, success: t('defaults.message.created', item: Question.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Question.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @question = Question.find(params[:id])
    @choices = @question.choices.order(created_at: :desc)
  end

  def edit; end

  def update
    if @question.update(update_question_params)
      redirect_to questions_path, success: t('defaults.message.updated', item: Question.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Question.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy!
    redirect_to questions_path, success: t('defaults.message.deleted', item: Question.model_name.human)
  end

  def correct_result 
    @question = Question.find(params[:question_id])
    @choices = @question.choices
  end

  def wrong_result 
    @question = Question.find(params[:question_id])
    @choices = @question.choices
  end

  def search
    @search_form = SearchQuestionsForm.new(search_question_params)
    @questions = @search_form.search.includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def set_question
    @question = current_user.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :image, :image_cache, :url, :sentence, choices_attributes: [:body, :correct_answer]).merge(user_id: current_user.id)
  end

  def update_question_params
    params.require(:question).permit(:title, :image, :image_cache, :url, :sentence, choices_attributes: [:body, :correct_answer, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def search_question_params
    params.fetch(:q, {}).permit(:title_or_sentence)
  end
end
