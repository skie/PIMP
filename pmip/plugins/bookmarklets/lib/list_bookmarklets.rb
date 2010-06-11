class ListBookmarklets < PMIPServlet
  def get(request, response, context)
    port = @args[:Port]
    path = @args[:Path]
    server = "http://localhost:#{port}/assets"

    content = '<html><body><title>The Bookmarklet Store</title><h3>Bookmarklet Store</h3><p>To install, drag the link to your toolbar/bookmark folder (or if in IE, right click -> add to favorites)</p><ul>'

    Path.new(path).each('*.js') {|f| content << "<li>" + link("#{server}/#{f.filename}", text(f)) + "</li>" }

    content << '</ul></body></html>'

    response.body = content
    response['Content-Type'] = "text/html"
  end

  private

  def link(uri, text)
    "<a href=\"javascript:(function(scriptURL)%20{%20var%20scriptElem%20=%20document.createElement('SCRIPT');%20scriptElem.setAttribute('language',%20'JavaScript');%20scriptElem.setAttribute('src','#{uri}');%20document.body.appendChild(scriptElem);})();\" mce_href=\"javascript:(function(scriptURL)%20{%20var%20scriptElem%20=%20document.createElement('SCRIPT');%20scriptElem.setAttribute('language',%20'JavaScript');%20scriptElem.setAttribute('src','#{uri}');%20document.body.appendChild(scriptElem);})();\">#{text}</a>"
  end

  def text(filepath)
    filepath.base.gsub('-', ' ')
  end
end