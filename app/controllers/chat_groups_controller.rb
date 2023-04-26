class ChatGroupsController < ApplicationController
  before_action :ensure_correct_user, only: %i[edit update]

  def index
    chat_groups = if (organization_name = params[:organization_name])
                    ChatGroup.with_organization(organization_name)
                  else
                    ChatGroup.all
    end
    @chat_groups = chat_groups.includes(:chat_group_users).order(created_at: :desc).page(params[:page])
    @organizations = Organization.all
    @organization_chat_groups = ChatGroup.includes(:organization).where(organization_id: params[:organization_id]).order(created_at: :desc).page(params[:page])
  end

  def new 
    @chat_group = ChatGroup.new
  end

  def join
    @chat_group = ChatGroup.find(params[:chat_group_id])
    @chat_group.users << current_user
    redirect_to chat_groups_path, success: t('defaults.join_chat_group')
  end

  def create
    @chat_group = current_user.chat_groups.build(chat_group_params)
    @chat_group.organization_id = params.dig(:chat_group, :organization, :organization_id)
    @chat_group.owner_id = current_user.id
    @chat_group.users << current_user
    if @chat_group.save
      redirect_to chat_groups_path, success: t('defaults.message.created', item: ChatGroup.model_name.human)
    else
      flash.now[:error] = t('defaults.message.not_created', item: ChatGroup.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @chat_group = ChatGroup.find(params[:id])
    @messages = @chat_group.messages
  end

  def edit; end

  def update
    @chat_group.organization_id = params.dig(:chat_group, :organization, :organization_id)
    if @chat_group.update(chat_group_params)
      redirect_to chat_groups_path, success: t('defaults.message.updated', item: ChatGroup.model_name.human)
    else
      flash.now[:error] = t('defaults.message.not_created', item: ChatGroup.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    delete_group = ChatGroup.find(params[:id])
    delete_group.destroy!
    redirect_to chat_groups_path, success: t('defaults.message.deleted', item: ChatGroup.model_name.human), status: :see_other
  end

  def leave
    @chat_group = ChatGroup.find(params[:chat_group_id])
    @chat_group.users.delete(current_user)
    redirect_to chat_groups_path, success: t('defaults.leave_chat_group')
  end

  def search
    @search_form = SearchChatGroupsForm.new(search_chat_group_params)
    @chat_groups = @search_form.search.includes(:chat_group_users).order(created_at: :desc).page(params[:page])
    @organizations = Organization.all
  end

  private

  def chat_group_params
    params.require(:chat_group).permit(:group_name, :group_description, :image, :image_cache)
  end

  def ensure_correct_user
    @chat_group = ChatGroup.find(params[:id])
    unless @chat_group.owner_id == current_user.id
      redirect_to chat_groups_path, error: t('defaults.not_creator')
    end
  end

  def search_chat_group_params
    params.fetch(:q, {}).permit(:group_name_or_group_description)
  end
    
end
