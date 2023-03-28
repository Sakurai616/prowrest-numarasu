import consumer from "./consumer"

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

    speak: function(message) {
      return this.perform('speak', {message: message});
    }

  });

  $(document).on('keypress', '[data-behavior~=chat_group_speaker]', function(event) {
    if (event.key === 'Enter') {
      chatChannel.speak(event.target.value);
      event.target.value = '';
      return event.preventDefault();
    }
  });
});