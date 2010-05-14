class ToggleGRFeedAndRecRules < PMIPAction
  REC = "/rec/"; FEED = "/feed/";

  def run(event, context)
    if context.editor?
      from = context.editor_filepath
      to = toggle_to(from, context)
      return if to.nil?
      results = Elements.new(context).find_file(to)
      if results.size() == 1
        result(from.reduce("gr/") + " -> " + to.reduce("gr/"))
        Navigator.new(context).open(results.first)
      elsif results.size != 1
        #TODO: should prompt to create it ... a la textdox
        result("expected to find one result to toggle with: " + from.reduce("gr/") + ", but found: #{results}")
      end
    end
  end

  private

  def toggle_to(filepath, context)
    fp = filepath.to_s
    #TODO: make filepath support replacements
    return Filepath.new(fp.sub(REC, FEED)) if fp.include?(REC)
    return Filepath.new(fp.sub(FEED, REC)) if fp.include?(FEED)
    nil
  end
end
