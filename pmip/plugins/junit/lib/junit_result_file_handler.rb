class JUnitResultFileHandler < NonCachingFileHandler
  def do_GET(req, res)
    root = Path.new(@root)
    if root.exist?
      super
    else
      res.body = "<html><body>Sorry, no junit test results found in: #{root}</body></html>"
    end
  end
end