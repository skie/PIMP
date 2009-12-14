import com.intellij.openapi.ui.Messages

class Dialogs
  def error(title, message)
    Messages.showErrorDialog(message, title);
  end
end
