class MessagesController < ApplicationController
  before_action :set_chat_group
  
  def create
    @message = @chat_group.messages.build(message_params)
    @message.user = current_user
  
    respond_to do |format|
      if @message.save
        format.html { redirect_to @chat_group }
        format.json { render json: @message, status: :created }
      else
        format.html { redirect_to @chat_group }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  def set_chat_group
    @chat_group = ChatGroup.find(params[:chat_group_id])
  end
  
  def message_params
    params.require(:message).permit(:body)
  end
end
  