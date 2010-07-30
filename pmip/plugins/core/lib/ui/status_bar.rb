import com.intellij.openapi.wm.WindowManager

class StatusBar
  def initialize(context = PMIPContext.new)
    @context = context
  end

  def set(message)
    status_bar = WindowManager.instance.get_status_bar(@context.project)
    status_bar.set_info(message) unless status_bar.nil?
  end
end