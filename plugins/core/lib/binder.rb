import com.intellij.openapi.actionSystem.ActionManager
import com.intellij.openapi.actionSystem.KeyboardShortcut
import com.intellij.openapi.keymap.KeymapManager
import javax.swing.KeyStroke;

class Binder
  def self.bind(key, action)
    action_manager = ActionManager.instance
    keymap = KeymapManager.instance.active_keymap

    #isTrue(action instanceof PMIPAction, "action must be a PMIPAction", action)
    id = action.name
    action_manager.unregister_action(id)
    keymap.remove_shortcut(id, shortcut(key))
    action_manager.register_action(id, action)
    keymap.add_shortcut(id, shortcut(key))
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
