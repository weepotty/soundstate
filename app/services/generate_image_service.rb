class GenerateImageService
  ART_STYLES = [
    'pop art', 'risograph', 'illustration', 'cubism', 'memphis', 'digital art',
    '3D render', 'block printing', 'watercolor', 'ceramics', 'vaporwave', 'linocut art',
    'geometric drawing', 'line art', 'vintage', '3D illustration', 'claymation',
    'salvador dali', 'van gogh', 'low poly'
  ].freeze

  TIME_COLOURS = {
    'morning': %w[spring dew dawn],
    'evening': %w[dusk twilight],
    'afternoon': %w[warm]
  }.freeze

  def self.call(song:, event:)
    # Various prompt helper words for better image generation results.
    image_response = client.images.generate(
      parameters: {
        prompt: "#{generated_prompt(song)},#{mood_descriptors(event).sample(2).join(', ')}, in the art style of #{ART_STYLES.sample}. use a colour palette inspired by #{time_colour_descriptor(event).sample}",
        size: '256x256'
      }
    )

    # Return the url of the image generated.
    image_response.dig('data', 0, 'url')
  end

  # Helper method to get descriptions to help enhance the image generated.
  def self.mood_descriptors(event)
    # very sad songs
    if event.max_valence < 0.4
      %w[winter somber melancholic sad gothic post-apocalyptic poignant]
    # happy energetic, less acoustic
    elsif event.max_valence > 0.6 && (event.max_energy > 0.6 || event.max_acousticness < 0.5)
      %w[bright vibrant dynamic spirited vivid lively energetic colorful joyful romantic expressive rich]
    # happy chill, more acoustic
    elsif event.max_valence > 0.6 && (event.max_energy < 0.6 || event.max_acousticness > 0.5)
      %w[light peaceful calm serene soothing relaxed cosy tranquil pastel ethereal tender soft]
    # neutral
    elsif event.max_valence < 0.6
      %w[harmonious natural diffuse whimsical]
    # discordant moods
    else
      %w[sublime symmetrical cool nostalgic]
    end
  end

  def self.time_colour_descriptor(event)
    TIME_COLOURS[event.time]
  end

  # Private method to generate prompt from the Song instance object.
  def self.generated_prompt(song)
    query = "Return the mood of the song #{song.name} by #{song.artist} in three words."

    response = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo', # Required.
        messages: [{ role: 'user', content: query }], # Required.
        temperature: 0.7
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end

  def self.client
    OpenAI::Client.new
  end
end
