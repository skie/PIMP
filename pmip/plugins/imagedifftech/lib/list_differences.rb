class ListDifferences < PMIPServlet
  def get(request, response, context)
    differences = @args[:DiffPath].files('*.png')
    response.body = differences.empty? ? render_done : render(differences)
  end

  private

  def render_done
    "<html><head><title>Resolve Image Differences</title></head><body><h3>Nothing to do!</h3></body></html>"
  end

  def render(differences)
    first = differences.first.filename
<<CONTENT
<html><head><title>Resolve Image Differences</title></head>
<body style="background-color:#EEEEEE;"><h3>Resolving: #{first} - (#{differences.size} left to resolve)</h3><div align="center">
<form action="resolve" method="POST">
<input type="hidden" name="#{FILENAME}" value="#{first}">
<input name="#{RESULT}" type="submit" value="#{HOT}" title="I wanted it to look EXACTLY like that, make it the new snapshot...">
<input name="#{RESULT}" type="submit" value="#{NOT}" title="Massive fail on my part, ignore it...">
</form></div>
<img style="border:1px solid black;" src="/diff/#{first}"/>
<h4>Checked in snapshot: (mouse over to show your changes)</h4><img onmouseover="this.src='/built/#{first}'" onmouseout="this.src='/snapshot/#{first}'" style="border:1px solid black;" src="/snapshot/#{first}"/>
</body></html>
CONTENT
  end
end