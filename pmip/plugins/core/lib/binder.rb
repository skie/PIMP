import com.intellij.openapi.actionSystem.ActionManager
import com.intellij.openapi.actionSystem.KeyboardShortcut
import com.intellij.openapi.keymap.KeymapManager
import javax.swing.KeyStroke;

PMIP_MENU = "PMIP::PopupMenu"

#TODO: consider holding onto all actions and keys - like mount, so they can be cleanly removed
class Binder
  def self.bind(key, action, force)
    key.sub!('banana', 'ctrl alt shift')
    key_map = KeymapManager.instance.active_keymap
    id = action.name
    action_manager = ActionManager.instance

    unregister(key, action, id, force, key_map, action_manager)
    register(key, action, id, key_map, action_manager)
    bind_menu(action, action_manager)

    key_binding = key == '' ? ' ' : " -> #{key} "
    puts "- Bound #{id}#{key_binding}#{render_usages(id)}"
    self
  end

  private

  def self.shortcut(key)
    KeyboardShortcut.new(key_stroke(key), nil)
  end

  def self.key_stroke(key)
    KeyStroke.get_key_stroke(key)
  end

  def self.bind_menu(action, action_manager)
    pmip_action_group = action_manager.get_action(PMIP_MENU)
    pmip_action_group.add(action)
  end

  def self.unregister(key, action, id, force, key_map, action_manager)
    action_manager.unregister_action(id)

    key_map.getActionIds(key_stroke(key)).each{|bound_id|
      if force
        key_map.remove_shortcut(bound_id, shortcut(key))
      else
        if bound_id != id
          raise "- Unable to bind #{id} -> #{key}, because shortcut is already used by '#{bound_id}', to override use: 'bind [key_stroke], [action], {:force = true}'"
        end
      end
    }
  end

  def self.register(key, action, id, key_map, action_manager)
    action_manager.register_action(id, action)
    key_map.add_shortcut(id, shortcut(key)) unless key == ''
  end

  #TOOD: remove duplication with mounter
  def self.render_usages(id)
    count = usages(id)
    count == 0 ? '' : "(#{count})"
  end
end

def bind(key, action='', options={})
  force = options[:force] ? true : false
  #TIP: yikes, nasty, if only one param then assume its an action without a key
  action == '' ? Binder.bind('', key, force) : Binder.bind(key, action, force)
end

#TODO: add $plugin namespace support
action_manager = ActionManager.instance
pmip_action_group = action_manager.getAction(PMIP_MENU)
pmip_action_group.remove_all