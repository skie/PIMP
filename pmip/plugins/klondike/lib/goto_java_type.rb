class GotoJavaType < PMIPAction
  def run(event, context)
    if context.editor?
      name = context.editor_current_word
      results = find_class_or_enum_on_failure(name, context)
      if results.size == 1
        result(name + " -> " + results.first.getQualifiedName)
        Navigator.new(context).open(results.first)
      else
        result("expected to find one java type for: #{name}, but found: #{results}")
      end
    end
  end

  private

  def find_class_or_enum_on_failure(name, context)
    results = Elements.new(context).find_class(implementation_name(name))
    results.empty? ? Elements.new(context).find_class(name) : results
  end

  def implementation_name(name)
    name.include?(POJO_BASED) ? name : POJO_BASED + name
  end
end