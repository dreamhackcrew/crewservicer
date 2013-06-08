atom_feed do |feed|
  feed.title("Crewinfo DreamHack")
  feed.updated(@messages.first.published_at) if @messages.length > 0

  @messages.each do |message|
    feed.entry(message, url: dashboard_url, published: message.published_at) do |entry|
      entry.title(message.headline)
      entry.content(simple_format(message.text), :type => 'html')
    end
  end
end
