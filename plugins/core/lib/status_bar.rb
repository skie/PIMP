import com.intellij.openapi.wm.WindowManager

class StatusBar
  def initialize(context)
    @context = context
  end

  def set(message)
    WindowManager.instance.get_status_bar(@context.project).set_info(message)
  end
end