import consumer from "./consumer"
import $ from "jquery";
$(function(){
  const chatChannel = consumer.subscriptions.create({ channel: "ChatGroupChannel", chat_group: $('#messages').data('chat_group_id') }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received: function(data) {
      return $('#messages').append(data['message']);
    },

    // 仮引数 function(message)のmessage
    // 実引数 event.target.value
    // chat_group_channel.rbのspeakアクションを動かすために、speak関数を定義
    speak: function(message) {
      return this.perform('speak', {message: message});
    }

  });

  // フォーム内でEnterキーが押された時の動作を記述
  // event.KeyCode === 13は非推奨となっているため、event.key === 'Enter'と変更
  $(document).on('keypress', '[data-behavior~=chat_group_speaker]', function(event) {
    if (event.key === 'Enter') {
      console.log(chatChannel);
      chatChannel.speak(event.target.value);
      event.target.value = '';
      return event.preventDefault();
    }
  });
});