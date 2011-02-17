class JUnitResultFileHandler < NonCachingFileHandler
  def do_GET(req, res)
    root = Path.new(@root)
    if root.exist?
      super
    else
      res.body = "<html><body>Sorry, no junit test reuslts found in: #{root}</body></html>"
    end
  end
end