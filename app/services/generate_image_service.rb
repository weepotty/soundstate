class GenerateImageService
  def self.call(song:, event:)
    # Generate the prompt from the Song instance object.
    prompt = generate_prompt(song)

    # Various prompt helper words for better image generation results.
    art_styles = ['pop art', 'risograph', 'illustration', 'cubism', 'memphis', 'digital art',
                  '3D render', 'block printing', 'watercolor', 'synthwave', 'ceramics', 'vaporwave', 'linocut art',
                  'geometric drawing', 'line art', 'vintage', '3D illustration', 'lego bricks', 'claymation',
                  'salvador dali', 'van gogh', 'low poly']
    # Generate image and returns image url.
    client = OpenAI::Client.new
    image_response = client.images.generate(parameters: { prompt: "#{prompt}, #{mood_descriptors(event).sample(2).join(', ')}, in the art style of #{art_styles.sample}. use a colour palette inspired by #{time_colour_descriptor(event).sample}", size: "256x256" })

    # Return the url of the image generated.
    img_res = image_response.dig('data', 0, 'url')
  end

  # Helper method to get descriptions to help enhance the image generated.
  def self.mood_descriptors(event)
    # happy energetic
    if event.max_valence > 0.6 && (event.max_energy > 0.6 || event.max_acousticness < 0.5)
      %w[bright vibrant dynamic spirited vivid lively energetic colorful joyful romantic expressive rich]
    # happy chill
    elsif event.max_valence > 0.6 && (event.max_energy < 0.6 || event.max_acousticness > 0.5)
      %w[light peaceful calm serene soothing relaxed cosy tranquil pastel ethereal tender soft]
    # sad chill
    elsif event.max_valence < 0.4
      %w[winter somber melancholic sad gothic post-apocalyptic poignant]
    # discordant moods
    else
      %w[sublime symmetrical cool]
    end
  end

  def self.time_colour_descriptor(event)
    case event.time
    when 'morning'
      %w[spring dawn]
    when 'evening'
      %w[dusk twilight]
    when 'afternoon'
      %w[summer autumn]
    end
  end

  # Private method to generate prompt from the Song instance object.
  def self.generate_prompt(song)
    query = "Return the mood of the song #{song.name} by #{song.artist} in three words."

    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo', # Required.
        messages: [{ role: 'user', content: query }], # Required.
        temperature: 0.7
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end

end
