class GenerateImageService
  def self.call(song:, event:)
    new(song:, event:).call
  end

  def initialize(song:, event:)
    @song = song
    @event = event
  end
  
  def call
    # Generate image and returns image url.
    image_response = client.images.generate(parameters: { prompt: generated_image_prompt, size: "256x256" })

    # Return the url of the image generated.
    image_response.dig('data', 0, 'url')
  end

  private

  attr_reader :song, :event

  def client
    @client ||= OpenAI::Client.new
  end

  # Helper method to generate prompt for image generation.
  def generated_image_prompt
    <<~HEREDOC
      #{generated_prompt_from_song}, 
      #{sample_mood_descriptors}, 
      in the art style of #{sample_art_style}. 
      use a colour palette inspired by #{sample_time_colour_descriptor}
    HEREDOC
  end

  # Private method to generate prompt from the Song instance object.
  def generated_prompt_from_song
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

  # Helper method to get art style to help enhance the image generated.
  def sample_art_style
    ['pop art', 'risograph', 'illustration', 'cubism', 'memphis', 'digital art',
    '3D render', 'block printing', 'watercolor', 'ceramics', 'vaporwave', 'linocut art',
    'geometric drawing', 'line art', 'vintage', '3D illustration', 'claymation',
    'salvador dali', 'van gogh', 'low poly'].sample
  end

  # Helper method to get color descriptors based on the time selected to help enhance the image generated.
  def sample_time_colour_descriptor
    time_colours = {
      morning: %w[spring dew dawn],
      evening: %w[dusk twilight],
      afternoon: %w[warm]
    }
    time_colours[event.time.to_sym].sample
  end

  # Helper methods to get mood descriptions to help enhance the image generated.
  def sample_mood_descriptors
    get_mood_descriptors.sample(2).join(', ')
  end

  def get_mood_descriptors
    if very_sad?
      %w[winter somber melancholic sad gothic post-apocalyptic poignant]
    elsif neutral?
      %w[harmonious natural diffuse whimsical]
    elsif happy_energetic_less_acoustic?
      %w[bright vibrant dynamic spirited vivid lively energetic colorful joyful romantic expressive rich]
    elsif happy_chill_more_acoustic?
      %w[light peaceful calm serene soothing relaxed cosy tranquil pastel ethereal tender soft]
    else
      %w[sublime symmetrical cool nostalgic]
    end
  end

  def very_sad?
    event.max_valence < 0.4
  end

  def neutral?
    event.max_valence < 0.6
  end

  def happy_energetic_less_acoustic?
    event.max_valence > 0.6 && (event.max_energy > 0.6 || event.max_acousticness < 0.5)
  end

  def happy_chill_more_acoustic?
    event.max_valence > 0.6 && (event.max_energy < 0.6 || event.max_acousticness > 0.5)
  end
end
