class GotoNamedQueryOrUsages < PMIPAction
  def run(event, context)
    if context.editor?
      context.editor_filepath.extension == 'xml' ? goto_usage(context) : goto_query(context)
    end
  end

  private

  def goto_usage(context)
    name = context.editor_current_word
    pattern = /"#{name}"/

    results = FindInFiles.new(Files.new(context).include('src/**/*.java')).pattern(pattern, name)

    if results.size == 1
      result = results.first
      result(result.describe)
      result.navigate_to(context)
    elsif results.size == 0
      result("#{name} doesnt seem to be used, delete it!")
    else
      result("#{name} used in #{results.size} places: #{results}")
    end
  end

  def goto_query(context)
    name = context.editor_current_word
    pattern = /<.*?query.*?name="#{name}".*/

    results = FindInFiles.new(Files.new(context).include('src/**/*.xml')).pattern(pattern, name)

    if results.size == 1
      result = results.first
      result(result.describe)
      result.navigate_to(context)
    else
      result("expected to find one named query for: #{name}, but found: #{results}")
    end
  end
end
