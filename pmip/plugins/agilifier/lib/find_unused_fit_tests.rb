class FindUnusedFitTests < PMIPAction
  ACCEPTANCE_TESTS = 'acceptance-tests-'

  def run(event, context)
    suites = Files.new(context).include('**/*.suite').find.
            collect{|f| f.readlines.collect{|l| l.strip.gsub('\\', '/')}.
            reject{|l| l.empty? || (l =~ /^\#/)} }.flatten.sort

    untested = Files.new(context).include(ACCEPTANCE_TESTS + '*/**/*.html').find.
            collect{|f| f.reduce(ACCEPTANCE_TESTS).gsub(ACCEPTANCE_TESTS, '').strip }.
            select{|f| !covered?(f, suites)}.
            reject{|f| f.include?('story.html')}

    result("#{untested.size} fit tests are not executed by any suites: \n" + untested.join("\n"))
  end

  private

  def covered?(test, suites)
    test = test.to_s.gsub('\\', '/')
    suites.each{|s| return true if test =~ /^#{s}/i }
    false
  end
end
