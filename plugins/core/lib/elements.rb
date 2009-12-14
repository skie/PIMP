import com.intellij.ide.util.gotoByName.GotoFileModel

class Elements
  def initialize(context)
    @context = context
  end

  def find_file(filepath)
    GotoFileModel.new(@context.project).getElementsByName(filepath.name, false, "").select do |e|
      filepath.to_s == e.getVirtualFile().getPath()
    end
  end
end
