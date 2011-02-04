class SearchInIntellijSources < SearchGitSource
  def run(event, context)
    text = Dialogs.new.input("Search Intellij Sources", "Search text (can be a regular expression):")
    return if text.nil? || text.empty?
    search("#{text}")
  end
end