class GotoMetaDataType < PMIPAction
  def run(event, context)
    if context.editor?
      name = context.editor_current_word.sub(POJO_BASED, '')
      pattern = /.*[type|enum].*name="#{name}".*/
      results = FindInFiles.new(Files.new(context).include('src/java/**/*metadata*.xml').
              exclude('src/java/**/*external-api.xml')).pattern(pattern, name)

      if results.size == 1
        result = results.first
        result(result.describe)
        result.navigate_to(context)
      else
        result("expected to find one metadata type for: #{name}, but found: #{results}")
      end
    end
  end
end
