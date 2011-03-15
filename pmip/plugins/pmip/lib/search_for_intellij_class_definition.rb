class SearchForIntellijClassDefinition < SearchGitSource
  def run(event, context)
    search(" (interface|class) #{context.current_editor.word} ")
  end
end