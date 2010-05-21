class FindFlakyTests < PMIPAction
  FLAKY = '//FLAKY'

  def run(event, context)
    pattern = /#{FLAKY}.*/
    results = FindInFiles.new(Files.new(context).include('src/test-selenium/**/*.java')).pattern(pattern, FLAKY)

    if results.empty?
      result("could not find any flaky tests!")
    else
      result("found #{results.size} flaky tests: #{sort(results)}")
    end
  end

  private

  def sort(results)
    results.sort{|r, other| other.content.size <=> r.content.size }
  end
end