class GotoFtlMacro < PMIPAction
  def run(event, context)
    if context.editor?
      name = context.editor_current_word
      pattern = /\[#macro.*#{name}.*/

      results = FindInFiles.new(Files.new(context).include('src/**/*.ftl')).pattern(pattern, name)

      if results.size == 1
        result = results.first
        result(result.describe)
        result.navigate_to(context)
      else
        result("expected to find one ftl macro for: #{name}, but found: #{results}")
      end
    end
  end
end
