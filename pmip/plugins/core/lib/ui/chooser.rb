import javax.swing.DefaultListModel
import javax.swing.JList
import com.intellij.openapi.ui.popup.PopupChooserBuilder
import com.intellij.ui.ColoredListCellRenderer

class RecentFilesRenderer < ColoredListCellRenderer
  def initialize(block)
    super()
    @block = block
  end

  def customizeCellRenderer(list, value, index, selected, hasFocus)
    @block.call(self, value)
  end
end

class Chooser
  def initialize(title, items, context)
    @title = title
    @items = items
    @context = context
  end

  def description(&block)
    @description_block = block
    self
  end

  def on_selected(&block)
    @on_selected_block = block
    self
  end

  def show
    #TODO: ensure block given for description and on_selected

    return @on_selected_block.call(@items.first) if @items.size == 1

    list_model = DefaultListModel.new
    @items.each{|i| list_model.addElement(i) }

    display_list = JList.new(list_model)
    display_list.setCellRenderer(renderer)

    PopupChooserBuilder.new(display_list).setTitle(@title).setMovable(true).setItemChoosenCallback(callback(display_list)).
        createPopup.showCenteredInCurrentWindow(@context.project)
  end

  private

  def renderer
    RecentFilesRenderer.new(lambda {|renderer, value| renderer.append(@description_block.call(value)) })
  end

  def callback(display_list)
    RunnableBlock.new(lambda { @on_selected_block.call(display_list.getSelectedValues()[0]) })
  end
end

#TODO:
#support for FindResult and Element out of the box
#consider support selection listener, south component, filtering and additional keystroke
#support icon
