class SearchForIntellijClassDefinition < SearchGitSource
  def run(event, context)
    search("class #{context.current_editor.word} ")
  end
end