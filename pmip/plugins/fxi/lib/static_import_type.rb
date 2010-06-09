class StaticImportType < PMIPAction
  def initialize(known_types)
    super()
    @known_types = known_types
  end

  def run(event, context)
    Refresh.file_system
    #TODO: make it work with inner classes/enums
    type = context.editor_current_word
    results = find_elements(type, context).collect{|t| t.qualified_name }.uniq

    if results.empty?
      result("could not find type to static import: #{type}")
    elsif results.size > 1
      result("expected to find one type for: #{type}, but found: #{results.join(', ')}")
    else
      result = results.first
      result("added static import for: #{type}")
      Refresh.file_system_after { mangle(context.editor_filepath, context.editor_current_line, type, result) }
    end
  end

  private

  def find_elements(type, context)
    elements = Elements.new(context).find_class(type, true)
    if !@known_types.has_key?(type)
      return elements
    else
      return [elements.select{|t| t.qualifiedName == @known_types[type] }.first]
    end
  end

  def mangle(file, line, type, qualified_type_name)
    lines = file.readlines.collect{|l| remove_usage_of_type(l, type) }
    lines.insert(2, "import static #{qualified_type_name}.*;")
    file.writelines(lines)
  end

  def remove_usage_of_type(line, type)
     return line if line =~ /^import/
     return '' if line.strip == type
     line.sub("#{type}.", '')
  end
end