class GotoCss < PMIPAction
  def run(event, context)
    line = context.editor_current_line
    line =~ /.*CssClass\("(.*?)"\).*/
    css = $1
    return if css.nil?

    results = FindInFiles.new(Files.new(context).include('src/java/**/spi.css')).pattern(/#{css}/, css)

    if results.empty?
      result("could not find css for: #{css}, maybe it can be deleted")
    else
      result = results.first
      result("found #{results.size} usages of css: #{css}#{results}")
      result.navigate_to(context)
    end
  end
end