class GotoCss < PMIPAction
  def run(event, context)
    line = context.current_editor.line
    line =~ /.*"(.*?)".*/
    css = $1
    return if css.nil?

    results = FindInFiles.new(Files.new.include('src/java/**/*.css')).pattern(/#{css}/, css)

    if results.empty?
      message = "could not find css for: #{css}, maybe it can be deleted"
      result(message)
      Balloon.new.info(message)
    else
      result("found #{results.size} usages of css: #{css}#{results}")

      Chooser.new("Goto css for: #{css}", results).
        description{|r| "#{r.line} - #{r.filepath.replace(context.root, '')}" }.
        preview_line{|r| r.content }.
        on_selected{|r| r.navigate_to.highlight_word }.
        show
    end
  end
end