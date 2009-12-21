import com.intellij.ide.util.gotoByName.GotoFileModel
import com.intellij.ide.util.gotoByName.GotoClassModel2

class Elements
  def initialize(context)
    @context = context
  end

  def find_file(filepath)
    GotoFileModel.new(@context.project).getElementsByName(filepath.filename, false, '').
      select{|e| filepath.to_s == e.virtual_file.path}
  end

  def findClass(name)
    GotoClassModel2.new(@context.project).getElementsByName(name, false, '').to_a
  end
end
