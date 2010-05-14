import com.intellij.openapi.actionSystem.ActionManager
import com.intellij.openapi.actionSystem.KeyboardShortcut
import com.intellij.openapi.keymap.KeymapManager
import javax.swing.KeyStroke;

PMIP_MENU = "PMIP::PopupMenu"

#TODO: consider holding onto all actions and keys - like mount, so they can be cleanly removed
class Binder
  def self.bind(key, action)
    key.sub!('banana', 'ctrl alt shift')
    keymap = KeymapManager.instance.active_keymap

    id = action.name
    action_manager = ActionManager.instance
    action_manager.unregister_action(id)
    keymap.remove_shortcut(id, shortcut(key)) unless key == ''
    action_manager.register_action(id, action)
    keymap.add_shortcut(id, shortcut(key)) unless key == ''

    pmip_action_group = action_manager.get_action(PMIP_MENU)
    pmip_action_group.add(action)
    key_binding = key == '' ? '' : " -> #{key} " 
    puts "- Bound #{id}#{key_binding}#{render_usages(id)}"
    self
  end

  private

  def self.shortcut(key)
    #TODO: fix convention
    KeyboardShortcut.new(KeyStroke.get_key_stroke(key), nil)
  end

  #TOOD: remove duplication with mounter
  def self.render_usages(id)
    count = usages(id)
    count == 0 ? '' : "(#{count})"
  end
end

def bind(key, action='')
  #TIP: yikes, nasty, if only one param then assume its an action without a key
  action == '' ? Binder.bind('', key) : Binder.bind(key, action)
end

#TODO: add $plugin namespace support
action_manager = ActionManager.instance
pmip_action_group = action_manager.getAction(PMIP_MENU)
pmip_action_group.remove_all