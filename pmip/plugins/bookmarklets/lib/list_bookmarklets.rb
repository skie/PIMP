class ListBookmarklets < PMIPServlet
  def get(request, response, context)
    port = @args[:Port]
    path = @args[:Path]
    server = "http://localhost:#{port}/assets"

    bookmarklets = path.files('*.js').collect {|f| "<li>" + link("#{server}/#{f.filename}", text(f)) + "</li>" }

    response.body = render(bookmarklets)
  end

  private

  def link(uri, text)
    "<a href=\"javascript:(function(scriptURL)%20{%20var%20scriptElem%20=%20document.createElement('SCRIPT');%20scriptElem.setAttribute('language',%20'JavaScript');%20scriptElem.setAttribute('src','#{uri}');%20document.body.appendChild(scriptElem);})();\">#{text}</a>"
  end

  def text(filepath)
    filepath.base.gsub('-', ' ')
  end

  def render(bookmarklets)
<<CONTENT
<html><head><title>The Bookmarklet Store</title></head>
<body><h3>Bookmarklet Store</h3>
<p>To install, drag the link to your toolbar/bookmark folder (or if in IE, right click -> add to favorites)</p>
<ul>#{bookmarklets.join}</ul>
</body></html>
CONTENT
  end
end