class SearchForIntellijClassUsages < SearchGitSource
  def run(event, context)
    search("#{context.current_editor.word}")
  end
end
