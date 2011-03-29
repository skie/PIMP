import com.intellij.ide.util.gotoByName.GotoFileModel
import com.intellij.ide.util.gotoByName.GotoClassModel2
import com.intellij.ide.util.gotoByName.GotoSymbolModel2
import com.intellij.psi.JavaPsiFacade
import com.intellij.psi.search.GlobalSearchScope

class Elements
  def initialize(context = PMIPContext.new)
    @context = context
    @cache = JavaPsiFacade.getInstance(@context.project).getShortNamesCache
  end

  #TODO: deprecate in favour of search_file?
  def find_file(filepath, include_external = false)
    GotoFileModel.new(@context.project).getElementsByName(filepath.filename, include_external, '').select{|e|
      #TIP: this cannot be changed to virtual_file because it fails on plugins written in scala (e.g. scala plugin)
      filepath.to_s == e.getVirtualFile.path
    }
  end

  #TODO: deprecate in favour of search_class?
  #TIP: only works with class names and not fully qualified names
  def find_class(name, include_external = false)
    GotoClassModel2.new(@context.project).getElementsByName(name, include_external, '').to_a
  end

  def find_symbol(name, include_external = false)
    GotoSymbolModel2.new(@context.project).getElementsByName(name, include_external, '').to_a
  end

  #TODO: should this be search_classes?
  def search_class(pattern, scope = global_scope)
    @cache.getAllClassNames().select{|name| name =~ pattern }.collect{|c| @cache.getClassesByName(c, scope) }.flatten
  end

  #TODO: should this be search_files?
  def search_file(pattern)
    @cache.getAllFileNames().select{|name| name =~ pattern }.collect{|f| @cache.getFilesByName(f) }.flatten
  end

  def global_scope
    GlobalSearchScope.projectScope(@context.project)
  end
end