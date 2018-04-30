class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_messages

  def index
  end

  def create
    message = current_user.messages.build messages_params
    @conversation = Conversation.current_conversation(current_user.id)[0]
    if message.conversation.newbie? message.user_id
      notify_to = message.conversation.expert.id
    else
      notify_to = message.conversation.newbie.id
    end
    if message.save
      ActionCable.server.broadcast "conversation_channel",
                                   message: render_message(message, @conversation),
                                   notify_to: notify_to
    else
      render :index
    end
  end

  private
  def find_messages
    @messages = Message.for_display
  end

  def messages_params
    params.require(:message).permit :content, :conversation_id
  end

  def render_message message, conversation
    render_to_string partial: "messages/message", locals: {message: message, conversation: conversation}
  end
end
