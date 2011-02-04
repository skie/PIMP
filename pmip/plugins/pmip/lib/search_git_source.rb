class SearchGitSource < PMIPAction
  GIT_INTELLIJ_SOURCE_SEARCH_URL = 'http://git.jetbrains.org/?p=idea/community.git&a=search&h=HEAD&st=grep&sr=1&s='

  def search(query)
    result(query)
    Browser.new.open(GIT_INTELLIJ_SOURCE_SEARCH_URL + query)
  end
end
