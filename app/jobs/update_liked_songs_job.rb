class UpdateLikedSongsJob < ApplicationJob
  queue_as :default

  def perform(current_user:)
    # Remove the songs_user if it is not updated within the last 60 minutes
    cutoff_time = Time.now - 3600
    current_user.songs_users.destroy_by("updated_at < ?", cutoff_time)
  end
end
