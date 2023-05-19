class ChatGroupChannel < ApplicationCable::Channel
  def subscribed
    # chat_group_channel.rbとchat_group_channel.jsでデータの送受信ができるようになる。
    stream_from "chat_group_channel_#{params['chat_group']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # jsで実行されたspeakのmessage、chat_group_idを受け取り、chat_group_channelのreceivedにブロードキャストする
    Message.create! body: data['message'], user_id: current_user.id, chat_group_id: data['chat_group_id']
  end
end
