class Browser
  def open(url)
    #TODO: currently windows specific
    `rundll32 url.dll,FileProtocolHandler #{url}`
  end
end
