import com.intellij.psi.presentation.java.SymbolPresentationUtil

class StaticImportSymbol < PMIPAction
  def run(event, context)
    Refresh.file_system
    type = context.current_editor.word
    results = find_elements(type).collect{|t| t.qualified_name }.uniq.sort

    if results.empty?
      result("could not find symbol to static import: #{type}")
    else
      result("found #{results.size} symbols for: #{type} - #{results.join(', ')}")

      Chooser.new("Static import symbol for: #{type}", results).
        description{|r| "#{r}" }.
        on_selected{|r| Refresh.file_system_after { mangle(context.editor_filepath, type, r) } }.
        show
    end
  end

  private

  def find_elements(type)
    Elements.new.find_symbol(type, true).collect{|element| find_classes_that_contain(element) }.flatten
  end

  def find_classes_that_contain(element)
    container_type = SymbolPresentationUtil.getSymbolContainerText(element)
    #TIP: horrible, but seems to be the only way to get the containing class
    container_type = container_type.sub('(in ', '').sub(')', '')
    #TIP: find_class only works with class names and not fully qualified names ...
    search_type = container_type.split('.').last
    Elements.new.find_class(search_type, true).select{|t| t.qualified_name == container_type }
  end

  def mangle(file, type, qualified_type_name)
    file.writelines(add_static_import(qualified_type_name, file.readlines))
  end

  def add_static_import(qualified_type_name, lines)
    import_line = "import static #{qualified_type_name}.*;"
    lines.insert(2, import_line) unless !lines.select { |l| l.strip == import_line }.empty?
    lines
  end
end