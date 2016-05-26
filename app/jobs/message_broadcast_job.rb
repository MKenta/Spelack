class MessageBroadcastJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast 'messages',
      message.to_json(methods: :nickname)
  end
end
