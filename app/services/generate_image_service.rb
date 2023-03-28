class GenerateImageService
  def self.call(song:, event:)
    # Generate the prompt from the Song instance object.
    prompt = generate_prompt(song)

    # Various prompt helper words for better image generation results.
    art_styles = ['pop art', 'risograph', 'illustration', 'colouring-in sheet', 'cubism', 'memphis', 'digital art',
                  '3D render', 'block printing', 'watercolor', 'synthwave', 'ceramics', 'vaporwave', 'linocut art']

    # Generate image and returns image url.
    client = OpenAI::Client.new
    image_response = client.images.generate(parameters: { prompt: "#{prompt}, #{mood_descriptors(event).sample(2).join(', ')}, in the art style of #{art_styles.sample}", size: "256x256" })

    img_res = image_response.dig('data', 0, 'url')
  end



  def self.mood_descriptors(event)
    # happy energetic
    if event.max_valence > 0.5 && event.max_energy > 0.5
      %w[bright vibrant dynamic spirited vivid lively energetic colorful joyful romantic expressive rich]
    # happy chill
    elsif event.max_valence > 0.5 && event.max_energy < 0.5
      %w[light peaceful calm serene soothing relaxed cosy tranquil pastel ethereal tender soft]
    # sad chill
    elsif event.max_valence < 0.4
      %w[winter somber melancholic sad gothic post-apocalyptic]
    # discordant moods
    else
      %w[sublime symmetrical vibrant vivid poignant]
    end
  end

  # Private method to generate prompt from the Song instance object.
  def self.generate_prompt(song)
    query = "Return a string of the meaning of the song #{song.name} by #{song.artist}. Limit to 10 words."

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
