class GotoCss < PMIPAction
  def run(event, context)
    line = context.editor_current_line
    line =~ /.*"(.*?)".*/
    css = $1
    return if css.nil?

    results = FindInFiles.new(Files.new(context).include('src/java/**/*.css')).pattern(/#{css}/, css)

    if results.empty?
      message = "could not find css for: #{css}, maybe it can be deleted"
      result(message)
      Balloon.new(context).info(message)
    else
      result = results.first
      result("found #{results.size} usages of css: #{css}#{results}")
      result.navigate_to(context).highlight_word
    end
  end
end