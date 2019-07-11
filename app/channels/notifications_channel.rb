class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_#{params[:channel_id]}"
  end
end
