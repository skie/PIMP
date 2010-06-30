import com.intellij.openapi.editor.LogicalPosition
import com.intellij.openapi.editor.ScrollType

class Navigator
  def initialize(context)
    @context = context
  end

  def open(element)
    element.navigate(true)
    self
  end

  def move_to(line, column)
    editor = @context.editor
    #TODO: restore notNull
    #position = LogicalPosition.new(notNull(line, "line"), notNull(column, "column"))
    position = LogicalPosition.new(line, column)
    editor.getCaretModel.moveToLogicalPosition(position)
    editor.getScrollingModel.disableAnimation
    editor.getScrollingModel.scrollTo(position, ScrollType::CENTER)
    editor.getScrollingModel.enableAnimation
    self
  end

  # DEPRECATED
  def highlight_word
    editor = @context.editor
    selection_model = editor.selection_model
    selection_model.select_word_at_caret(true)
  end

  # DEPRECATED
  def highlight_line
    editor = @context.editor
    selection_model = editor.selection_model
    selection_model.select_line_at_caret
  end
end