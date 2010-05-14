class Fit
  PREFIX = "acceptance-tests-"

  def initialize(context)
    @context = context
  end

  def selected_tests
    @context.selected_psi_elements.inject([]) {|r, e| r << extract(e.virtual_file.path) if valid(e); r }
  end

  private

  def valid(element)
    #TODO: use filepath for this
    #.ends?(".html")
    return false if element.virtual_file.nil?
    element.virtual_file.path.include?(PREFIX) && (element.directory? || element.virtual_file.path =~ /\.html$/)
  end

  def extract(test)
    #text(test).removeUptoFirst(PREFIX).removeFirst(PREFIX).getAsString()
    #TODO: sort this crap out - introduce Text - with removeUptoFirst
    test[(test.index(PREFIX) + PREFIX.size)..-1]
  end
end
