class ImportSongRecommendationsJob < ApplicationJob
  queue_as :default

  def perform(current_user:)
    ::ImportSongRecommendationsService.call(current_user:)
  end
end
