class OpenFitResult < PMIPAction
  def run(event, context)
    selected_tests = Fit.new(context).selected_tests
    if selected_tests.size() == 1
      url = result_or_source_if_missing(context, selected_tests.first)
      #TODO: this must appear elsewhere ... remove duplication
      #TODO: fix this, its currently blowing with a NPE
      #result(url[url.index(Fit::PREFIX) + Fit::PREFIX.size, url.size])
      Browser.new.open(url)
    end
  end

  private

  #TODO: fix slight bug here when its not a result and not .html - opens explorer in directory (on windows at least)
  def result_or_source_if_missing(context, selected_test)
    result = context.filepath_from_root("build/reports/agilifier/" + selected_test)
    result.exist? && result.ends?(".html") ? result.to_s : context.filepath_from_root(Fit::PREFIX + selected_test).to_s
  end
end