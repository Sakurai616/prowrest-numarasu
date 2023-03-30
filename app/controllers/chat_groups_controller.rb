class ChatGroupsController < ApplicationController
  before_action :set_chat_group, only: %i[show edit update]

  def index
    @chat_group_lists = ChatGroup.all
  end

  def new 
    @chat_group = ChatGroup.new
    @chat_group.users << current_user
  end

  def create
    @chat_group = ChatGroup.new(chat_group_params)
    if @chat_group.save
      redirect_to chat_groups_path, success: t('defaults.message.created', item: ChatGroup.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: ChatGroup.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @messages = @chat_group.messages
  end

  def edit; end

  def update
    if @chat_group.update(chat_group_params)
      redirect_to chat_groups_path, success: t('defaults.message.updated', item: ChatGroup.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: ChatGroup.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    delete_group = ChatGroup.find(params[:id])
    if delete_group.destroy
      redirect_to chat_groups_path, success: t('defaults.message.deleted', item: ChatGroup.model_name.human), status: :see_other
    end
  end

  private

  def set_chat_group
    @chat_group = ChatGroup.find(params[:id])
  end

  def chat_group_params
    params.require(:chat_group).permit(:group_name, :group_description, :image, :image_cache, user_ids: [])
  end
    
end
