class MessageBroadcastJob < ApplicationJob
  queue_as :default

  # ブロードキャスト(一つのネットワークの中にあるすべてのホストに対してデータを送る。)
  def perform(message, chat_group_id)
    ActionCable.server.broadcast "chat_group_channel_#{message.chat_group_id}", { message: render_message(message) }
  end

  private
  # app/views/message/_message.html.erbを呼び出す。
  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
