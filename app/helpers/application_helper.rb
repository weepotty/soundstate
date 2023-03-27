module ApplicationHelper
  module ApplicationHelper
    def embedded_svg(filename, options = {})
      assets = Rails.application.assets
      asset = assets.find_asset(filename)

      if asset
        file = asset.source.force_encoding('UTF-8')
        doc = Nokogiri::HTML::DocumentFragment.parse file
        svg = doc.at_css 'svg'
        svg['class'] = options[:class] if options[:class].present?
      else
        doc = "<!-- svg #{filename} not found -->"
      end

      raw doc
    end
  end
end
