class GotoGrImport < PMIPAction
  def run(event, context)
    if context.editor?
      from = context.editor_filepath
      line = context.editor_current_line
      return if line.index('#import').nil?

      file = line[line.index('/'), line.size].strip
      to = context.filepath_from_root("src/java#{file}")
      results = Elements.new(context).find_file(to)

      if results.size == 1
        result(from.reduce('gr/') + ' -> ' + to.reduce('gr/'))
        Navigator.new(context).open(results.first)
      else
        result("expected to find one gr import file for: #{to.reduce('gr/')}, but found: #{results}")
      end
    end
  end
end
