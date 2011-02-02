import com.intellij.ide.util.gotoByName.GotoFileModel
import com.intellij.ide.util.gotoByName.GotoClassModel2
import com.intellij.ide.util.gotoByName.GotoSymbolModel2

class Elements
  def initialize(context = PMIPContext.new)
    @context = context
  end

  def find_file(filepath, include_external = false)
    GotoFileModel.new(@context.project).getElementsByName(filepath.filename, include_external, '').
      select{|e|
      #TIP: this cannot be changed to virtual_file because it fails on plugins written in scala (e.g. scala plugin)
      filepath.to_s == e.getVirtualFile.path
    }
  end

  #TIP: only works with class names and not fully qualified names
  def find_class(name, include_external = false)
    GotoClassModel2.new(@context.project).getElementsByName(name, include_external, '').to_a
  end

  def find_symbol(name, include_external = false)
    GotoSymbolModel2.new(@context.project).getElementsByName(name, include_external, '').to_a
  end
end