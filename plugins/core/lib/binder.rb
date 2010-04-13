import com.intellij.openapi.actionSystem.ActionManager
import com.intellij.openapi.actionSystem.KeyboardShortcut
import com.intellij.openapi.keymap.KeymapManager
import javax.swing.KeyStroke;

class Binder
  def self.bind(key, action)
    key.sub!('banana', 'ctrl alt shift')
    action_manager = ActionManager.instance
    keymap = KeymapManager.instance.active_keymap

    id = action.name
    action_manager.unregister_action(id)
    keymap.remove_shortcut(id, shortcut(key))
    action_manager.register_action(id, action)
    keymap.add_shortcut(id, shortcut(key))

    #TODO: make constant
    pmipActionGroup = action_manager.getAction("PMIP::PopupMenu")
    pmipActionGroup.add(action)
    
    puts "- Bound #{id} -> #{key}"
    self
  end

  private

  def self.shortcut(key)
    KeyboardShortcut.new(KeyStroke.get_key_stroke(key), nil)
  end
end

def bind(key, action)
  Binder.bind(key, action)
end

action_manager = ActionManager.instance
#TODO: make constant
pmip_action_group = action_manager.getAction("PMIP::PopupMenu")
pmip_action_group.remove_all
