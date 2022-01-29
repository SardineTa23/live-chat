class RoomChannel < ApplicationCable::Channel
  def subscribed
    def subscribedstream_from 'room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # Vue.js側からemailとmessageを含んだデータが送られてくる
  def receive(data)
    user = User.find_by(email: data['email'])
    
    if message = Message.create(content: data['message'], user_id: user.id)
      ActionCable.server.broadcast 'room_channel',
        { 
          message: data['message'], 
          name: user.name, 
          created_at: message.created_at 
        }
    end
  end
end
