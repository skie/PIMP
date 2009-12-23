class GotoWorkflowStep < PMIPAction
  def initialize(prefix)
    super("Goto" + prefix + "WorkflowStep")
    @prefix = prefix
  end

  def run(event, context)
    if context.editor?
      name = context.editor_current_word
      return if name.nil? || name.size < 2
      #TODO: sentance case?
      implementation_name = name[0..0].upcase + name[1..-1]
      results = find_implementation(implementation_name, context)
      if results.size == 1
        result(name + " -> " + results.first.getQualifiedName)
        Navigator.new(context).open(results.first)
      else
        result("expected to find one implementation for: #{implementation_name}, but found: #{results}")
      end
    end
  end

  def find_implementation(name, context)
    found = Elements.new(context).findClass(@prefix + name)
    !found.empty? ? found : Elements.new(context).findClass(name)
  end
end