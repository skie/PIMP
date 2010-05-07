import com.intellij.openapi.wm.ToolWindowManager
import com.intellij.openapi.ui.MessageType

class Balloon
  def initialize(context)
    @context = context
  end

  def info(message)
    balloon(MessageType::INFO, message)
  end

  def warning(message)
    balloon(MessageType::WARNING, message)
  end

  def error(message)
    balloon(MessageType::ERROR, message)
  end

  private

  def balloon(type, message)
    ToolWindowManager.getInstance(@context.project).notifyByBalloon('PMIP', type, message, nil, nil)
  end
end