class StaticImportType < PMIPAction
  def initialize(known_types={})
    super()
    @known_types = known_types
  end

  #TODO: make it work with inner classes/enums
  def run(event, context)
    Refresh.file_system
    type = context.editor_current_word
    results = find_elements(type, context).collect{|t| t.qualified_name }.uniq.sort

    if results.empty?
      result("could not find type to static import: #{type}")
    else
      result("found #{results.size} types for: #{type} - #{results.join(', ')}")

      Chooser.new("Static import type for: #{type}", results, context).
        description{|r| "#{r}" }.
        on_selected{|r| Refresh.file_system_after { mangle(context.editor_filepath, type, r) } }.
        show
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

  def mangle(file, type, qualified_type_name)
    file.writelines(add_static_import(qualified_type_name, remove_usages(type, file)))
  end

  def remove_usages(type, file)
    file.readlines.collect {|l| remove_usage_of_type(l, type) }
  end

  def remove_usage_of_type(line, type)
     return line if line =~ /^import/
     return '' if line.strip == type
     #TIP: the \w and \1 bit is stop var ags being removed
     line.gsub(/#{type}\.(\w)/, '\1')
  end

  def add_static_import(qualified_type_name, lines)
    import_line = "import static #{qualified_type_name}.*;"
    lines.insert(2, import_line) unless !lines.select { |l| l.strip == import_line }.empty?
    lines
  end
end